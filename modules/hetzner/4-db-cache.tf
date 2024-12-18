# Generate a random password for the DB root user
resource "random_password" "db_pass" {
  length           = 32
  special          = false
}

# Generate a random password for the Redis root user
resource "random_password" "redis_pass" {
  length           = 32
  special          = false
}

# Create a PostgreSQL database server
resource "hcloud_server" "db" {
  name        = "${var.environment}-${var.project}-db"
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys = [ hcloud_ssh_key.db.id ]
  # Assign the server to the private database subnet
  # IP address:
    # 10.0.2.10
  network {
    network_id = hcloud_network.vpc.id
    ip         = "${cidrhost(var.private_db_subnet_cidr, 10)}"
  }
  # Cloud-init user data to reset the root password
  user_data = <<-EOF
              #cloud-config
              password: ${random_password.db_pass.result}
              ssh_pwauth: false
              chpasswd:
                expire: False
              EOF
  # Labels for the server
  labels = {
    project     = var.project
    environment = var.environment
    role        = "db"
    location    = var.server_location
  }
  depends_on = [ hcloud_network_subnet.private_db, hcloud_ssh_key.db ]
}

# Create a Redis server
resource "hcloud_server" "redis" {
  name        = "${var.environment}-${var.project}-redis"
  image       = var.server_image
  server_type = var.server_type
  location    = var.server_location
  ssh_keys = [ hcloud_ssh_key.redis.id ]
  # Assign the server to the private Redis subnet
  # IP address:
    # 10.0.3.10
  network {
    network_id = hcloud_network.vpc.id
    ip         = "${cidrhost(var.private_redis_subnet_cidr, 10)}"
  }
  # Cloud-init user data to reset the root password
  user_data = <<-EOF
              #cloud-config
              password: ${random_password.redis_pass.result}
              ssh_pwauth: false
              chpasswd:
                expire: False
              EOF
  # Labels for the server
  labels = {
    project     = var.project
    environment = var.environment
    role        = "redis"
    location    = var.server_location
  }
  depends_on = [ hcloud_network_subnet.private_redis, hcloud_ssh_key.redis ]
}