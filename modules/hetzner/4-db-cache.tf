# Create a PostgreSQL database server
resource "hcloud_server" "db" {
  name        = "${var.environment}-${var.project}-db"
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys = [ hcloud_ssh_key.cluster_controls.id ]
  # Assign the server to the private database subnet
  # IP address:
    # 10.0.2.10
  network {
    network_id = hcloud_network.vpc.id
    ip         = "${cidrhost(var.private_db_subnet_cidr, 10)}"
  }
  labels = {
    project     = var.project
    environment = var.environment
    role        = "db"
  }
  depends_on = [ hcloud_network_subnet.private_db, hcloud_ssh_key.cluster_controls ]
}

# Create a Redis server
resource "hcloud_server" "redis" {
  name        = "${var.environment}-${var.project}-redis"
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys = [ hcloud_ssh_key.cluster_controls.id ]
  # Assign the server to the private Redis subnet
  # IP address:
    # 10.0.3.10
  network {
    network_id = hcloud_network.vpc.id
    ip         = "${cidrhost(var.private_redis_subnet_cidr, 10)}"
  }
  labels = {
    project     = var.project
    environment = var.environment
    role        = "redis"
  }
  depends_on = [ hcloud_network_subnet.private_redis, hcloud_ssh_key.cluster_controls ]
}