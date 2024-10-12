output "control_plane_ssh_key_name" {
  description = "Name of the SSH key for the control plane nodes"
  value       = module.hetzner_infrastructure.control_plane_ssh_key_name
}

output "control_plane_ssh_key_password" {
  description = "Password for the SSH key for the control plane nodes"
  value       = nonsensitive(module.hetzner_infrastructure.control_plane_ssh_key_password)
  #sensitive   = true
}

output "worker_ssh_key_name" {
  description = "Name of the SSH key for the worker nodes"
  value       = module.hetzner_infrastructure.worker_ssh_key_name
}

output "worker_ssh_key_password" {
  description = "Password for the SSH key for the worker nodes"
  value       = nonsensitive(module.hetzner_infrastructure.worker_ssh_key_password)
  #sensitive   = true
}

output "db_ssh_key_name" {
  description = "Name of the SSH key for the database server"
  value       = module.hetzner_infrastructure.db_ssh_key_name
}

output "db_ssh_key_password" {
  description = "Password for the SSH key for the database server"
  value       = nonsensitive(module.hetzner_infrastructure.db_ssh_key_password)
  #sensitive   = true
}

output "redis_ssh_key_name" {
  description = "Name of the SSH key for the Redis server"
  value       = module.hetzner_infrastructure.redis_ssh_key_name
}

output "redis_ssh_key_password" {
  description = "Password for the SSH key for the Redis server"
  value       = nonsensitive(module.hetzner_infrastructure.redis_ssh_key_password)
  #sensitive   = true
}

output "control_plane_ips" {
  description = "List of public IPs for control plane nodes"
  value       = module.hetzner_infrastructure.control_plane_ips
}

output "worker_ips" {
  description = "List of public IPs for worker nodes"
  value       = module.hetzner_infrastructure.worker_ips
}

output "db_ip" {
  description = "Private IP for the database server"
  value       = module.hetzner_infrastructure.db_ip
}

output "redis_ip" {
  description = "Private IP for the Redis server"
  value       = module.hetzner_infrastructure.redis_ip
}