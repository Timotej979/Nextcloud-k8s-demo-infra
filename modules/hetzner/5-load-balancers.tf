# Create load balancer for ingress
resource "hcloud_load_balancer" "ingress" {
  name            = "${var.environment}-${var.project}-ingress"
  load_balancer_type = "lb11"
  location        = var.server_location
  delete_protection = var.environment == "prod" ? true : false

  algorithm {
    type = "round_robin"
  }

  labels = {
    k8s-role = "ingress"
    location = var.server_location
  }
}

# Attach the ingress load balancer to the private network
resource "hcloud_load_balancer_network" "ingress_network" {
  load_balancer_id = hcloud_load_balancer.ingress.id
  network_id       = hcloud_network.vpc.id
  ip               = "${cidrhost(var.public_subnet_cidr, 200)}"
  depends_on = [ hcloud_network.vpc, hcloud_network_subnet.public, hcloud_load_balancer.ingress ]
}

# Add targets to the ingress load balancer (multiple worker servers)
resource "hcloud_load_balancer_target" "ingress_target" {
  load_balancer_id = hcloud_load_balancer.ingress.id
  type             = "server"
  
  count = length(hcloud_server.worker)  # Set the count to the number of worker servers

  server_id      = hcloud_server.worker[count.index].id  # Reference the worker server by index
  use_private_ip = true                      # Use private IPs for ingress targets
  depends_on     = [ hcloud_server.worker, hcloud_load_balancer.ingress ]
}
