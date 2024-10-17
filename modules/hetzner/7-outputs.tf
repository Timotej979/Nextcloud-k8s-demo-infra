# Control plane SSH credentials
output "control_plane_ssh_key_name" {
  description = "Name of the SSH key for the control plane nodes"
  value       = hcloud_ssh_key.cluster_controls.name
}

output "control_plane_ssh_key_path" {
  description = "Path to the SSH key for the control plane nodes"
  value       = "~/.ssh/nextcloud_demo_cluster_control"
}

# Worker SSH credentials
output "worker_ssh_key_name" {
  description = "Name of the SSH key for the worker nodes"
  value       = hcloud_ssh_key.cluster_workers.name
}

output "worker_ssh_key_path" {
  description = "Path to the SSH key for the worker nodes"
  value       = "~/.ssh/nextcloud_demo_cluster_worker"
}

# Database SSH credentials
output "db_ssh_key_name" {
  description = "Name of the SSH key for the database server"
  value       = hcloud_ssh_key.db.name
}

output "db_ssh_key_path" {
  description = "Path to the SSH key for the database server"
  value       = "~/.ssh/nextcloud_demo_db"
}

# Redis SSH credentials
output "redis_ssh_key_name" {
  description = "Name of the SSH key for the Redis server"
  value       = hcloud_ssh_key.redis.name
}

output "redis_ssh_key_path" {
  description = "Path to the SSH key for the Redis server"
  value       = "~/.ssh/nextcloud_demo_redis"
}

# Control plan IPs
output "control_plane_ips" {
  description = "List of public IPs for control plane nodes"
  value       = hcloud_server.control_plane[*].ipv4_address
}

# Worker IPs
output "worker_ips" {
  description = "List of public IPs for worker nodes"
  value       = hcloud_server.worker[*].ipv4_address
}

# Database IPs
output "db_ip" {
  description = "Private IP for the database server"
  value       = hcloud_server.db.ipv4_address
}

output db_internal_ip {
  description = "Private IP for the database server"
  value       = "${cidrhost(var.private_db_subnet_cidr, 10)}"
}

# Redis IPs
output "redis_ip" {
  description = "Private IP for the Redis server"
  value       = hcloud_server.redis.ipv4_address
}

output "redis_internal_ip" {
  description = "Private IP for the database server"
  value       = "${cidrhost(var.private_redis_subnet_cidr, 10)}"
}

# Control plane root password
#output "control_plane_root_password" {
#  description = "Root password for the control plane nodes"
#  value       = random_password.control_plane_pass.result
#}

# Worker root password
#output "worker_root_password" {
#  description = "Root password for the worker nodes"
#  value       = random_password.worker_pass.result
#}

# Database root password
output "db_root_password" {
  description = "Root password for the database server"
  value       = random_password.db_pass.result
}

# Redis root password
output "redis_root_password" {
  description = "Root password for the Redis server"
  value       = random_password.redis_pass.result
}