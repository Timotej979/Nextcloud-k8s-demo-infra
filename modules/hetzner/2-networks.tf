# Create a VPC network for the servers
resource "hcloud_network" "vpc" {
  name       = "${var.environment}-${var.project}-vpc"
  ip_range   = var.vpc_net_cidr 
  delete_protection = var.environment == "prod" ? true : false
  labels = {
    project = var.project
    environment = var.environment
  }
}

# Public subnet for Kubernetes cluster (Nextcloud frontend)
resource "hcloud_network_subnet" "public" {
  network_id   = hcloud_network.vpc.id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = var.public_subnet_cidr  # Public subnet for frontend (e.g., "10.0.1.0/24")
  depends_on = [ hcloud_network.vpc ]
}

# Private subnet for the database (PostgreSQL/MySQL)
resource "hcloud_network_subnet" "private_db" {
  network_id   = hcloud_network.vpc.id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = var.private_db_subnet_cidr  # Private subnet for database (e.g., "10.0.2.0/24")
  depends_on = [ hcloud_network.vpc ]
}

# Private subnet for Redis caching
resource "hcloud_network_subnet" "private_redis" {
  network_id   = hcloud_network.vpc.id
  type         = "cloud"
  network_zone = var.network_zone
  ip_range     = var.private_redis_subnet_cidr  # Private subnet for Redis (e.g., "10.0.3.0/24")
  depends_on = [ hcloud_network.vpc ]
}

