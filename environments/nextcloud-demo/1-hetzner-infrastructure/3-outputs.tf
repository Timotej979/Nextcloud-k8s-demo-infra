output "hcloud_token" {
  description = "Hetzner Cloud API token"
  value       = var.hcloud_token
  sensitive   = true
}

#################################################################################

output "vpc_network_id" {
  description = "The ID of the Hetzner Cloud network"
  value       = module.hetzner_infrastructure.vpc_network_id
}

# Public subnet CIDR
output "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  value       = module.hetzner_infrastructure.public_subnet_cidr
}

# Ingress load balancer IP
output "ingress_lb_name" {
  description = "Name of the ingress load balancer"
  value       = module.hetzner_infrastructure.ingress_lb_name
}

# Load balancer ingress IP
output "server_location" {
  description = "The location of the Hetzner Cloud servers"
  value       = module.hetzner_infrastructure.server_location
}

#################################################################################

# Control plane IP
output "control_plane_ip" {
  description = "IP of the control plane node"
  value       = module.hetzner_infrastructure.control_plane_ip
}

# Worker IPs
output "worker_ips" {
  description = "List of public IPs for worker nodes"
  value       = module.hetzner_infrastructure.worker_ips
}

# Database IP
output "db_ip" {
  description = "Private IP for the database server"
  value       = module.hetzner_infrastructure.db_ip
}

output "db_internal_ip" {
  description = "Private IP for the database server"
  value       = module.hetzner_infrastructure.db_internal_ip
}

# Redis IP
output "redis_ip" {
  description = "Private IP for the Redis server"
  value       = module.hetzner_infrastructure.redis_ip
}

output "redis_internal_ip" {
  description = "Private IP for the Redis server"
  value       = module.hetzner_infrastructure.redis_internal_ip
}

#################################################################################

# Database root password
output "db_server_root_password" {
  description = "Root password for the database server"
  value       = module.hetzner_infrastructure.db_server_root_password
  sensitive   = true
}

# Redis root password
output "redis_server_root_password" {
  description = "Root password for the Redis server"
  value       = module.hetzner_infrastructure.redis_server_root_password
  sensitive   = true
}

#################################################################################

# Control plane key
output "control_plane_ssh_key_name" {
  description = "Name of the SSH key for the control plane nodes"
  value       = module.hetzner_infrastructure.control_plane_ssh_key_name
}

output "control_plane_ssh_key_path" {
  description = "Path to the SSH key for the control plane nodes"
  value       = module.hetzner_infrastructure.control_plane_ssh_key_path
}

# Worker key
output "worker_ssh_key_name" {
  description = "Name of the SSH key for the worker nodes"
  value       = module.hetzner_infrastructure.worker_ssh_key_name
}

output "worker_ssh_key_path" {
  description = "Path to the SSH key for the worker nodes"
  value       = module.hetzner_infrastructure.worker_ssh_key_path
}

# Database key
output "db_ssh_key_name" {
  description = "Name of the SSH key for the database server"
  value       = module.hetzner_infrastructure.db_ssh_key_name
}

output "db_ssh_key_path" {
  description = "Path to the SSH key for the database server"
  value       = module.hetzner_infrastructure.db_ssh_key_path
}

# Redis key
output "redis_ssh_key_name" {
  description = "Name of the SSH key for the Redis server"
  value       = module.hetzner_infrastructure.redis_ssh_key_name
}

output "redis_ssh_key_path" {
  description = "Path to the SSH key for the Redis server"
  value       = module.hetzner_infrastructure.redis_ssh_key_path
}

