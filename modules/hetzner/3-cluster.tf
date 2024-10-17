# Generate a random password for the control_plane root user
resource "random_password" "control_plane_root_password" {
  length           = 32
  special          = false
}

# Generate a random password for the workers root user
resource "random_password" "workers_root_password" {
  length           = 32
  special          = false
}

# Create control plane nodes for the Kubernetes cluster
resource "hcloud_server" "control_plane" {
  count       = var.num_control_plane_nodes
  name        = "${var.environment}-${var.project}-control-plane-${count.index}"
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys    = [ hcloud_ssh_key.cluster_controls.id ]
  # Assign the server to the public subnet
  # Control plane nodes have IP addresses as follows:
    # 10.0.1.10
    # 10.0.1.11
    # 10.0.1.12
  network {
    network_id = hcloud_network.vpc.id
    ip         = "${cidrhost(var.public_subnet_cidr, count.index + 10)}"
  }
  # Cloud init user data to reset the root password
  user_data = <<-EOF
              #cloud-config
              password: ${random_password.control_plane_root_password.result}
              chpasswd:
                expire: False
              EOF
  # Labels for the server
  labels = {
    project     = var.project
    environment = var.environment
    role        = "control-plane"
  }
  depends_on = [ hcloud_network_subnet.public, hcloud_ssh_key.cluster_controls ]
}

# Create worker nodes for the Kubernetes cluster
resource "hcloud_server" "worker" {
  count       = var.num_worker_nodes
  name        = "${var.environment}-${var.project}-worker-${count.index}"
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys    = [ hcloud_ssh_key.cluster_controls.id ]
  # Assign the server to the public subnet
  # Worker nodes have IP addresses as follows:
    # 10.0.1.20
    # 10.0.1.21
    # 10.0.1.22
  network {
    network_id = hcloud_network.vpc.id
    ip         = "${cidrhost(var.public_subnet_cidr, count.index + 20)}"
  }
  # Cloud init user data to reset the root password
  user_data = <<-EOF
              #cloud-config
              password: ${random_password.workers_root_password.result}
              chpasswd:
                expire: False
              EOF
  # Labels for the server
  labels = {
    project     = var.project
    environment = var.environment
    role        = "worker"
  }
  depends_on = [ hcloud_network_subnet.public, hcloud_ssh_key.cluster_controls ]
}