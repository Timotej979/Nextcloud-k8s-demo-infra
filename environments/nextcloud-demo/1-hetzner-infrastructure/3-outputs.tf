# Public subnet CIDR
output "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  value       = module.hetzner_infrastructure.public_subnet_cidr
}

# Control plane IPs
output "control_plane_ips" {
  description = "List of public IPs for control plane nodes"
  value       = module.hetzner_infrastructure.control_plane_ips
}

output "worker_ips" {
  description = "List of public IPs for worker nodes"
  value       = module.hetzner_infrastructure.worker_ips
}

# Database IPs
output "db_ip" {
  description = "Private IP for the database server"
  value       = module.hetzner_infrastructure.db_ip
}

output "db_internal_ip" {
  description = "Private IP for the database server"
  value       = module.hetzner_infrastructure.db_internal_ip
}

# Redis IPs
output "redis_ip" {
  description = "Private IP for the Redis server"
  value       = module.hetzner_infrastructure.redis_ip
}

output "redis_internal_ip" {
  description = "Private IP for the Redis server"
  value       = module.hetzner_infrastructure.redis_internal_ip
}

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

