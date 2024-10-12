output "control_plane_ssh_key_name" {
  description = "Name of the SSH key for the control plane nodes"
  value       = hcloud_ssh_key.cluster_controls.name
}

output "ciontrol_plan_ssh_key_password" {
  description = "Password for the SSH key for the control plane nodes"
  value       = random_password.cluster_control_ssh_key_password.result
}

output "worker_ssh_key_name" {
  description = "Name of the SSH key for the worker nodes"
  value       = hcloud_ssh_key.cluster_workers.name
}

output "worker_ssh_key_password" {
  description = "Password for the SSH key for the worker nodes"
  value       = random_password.cluster_worker_ssh_key_password.result
}

output "db_ssh_key_name" {
  description = "Name of the SSH key for the database server"
  value       = hcloud_ssh_key.db.name
}

output "db_ssh_key_password" {
  description = "Password for the SSH key for the database server"
  value       = random_password.db_ssh_key_password.result
  
}

output "redis_ssh_key_name" {
  description = "Name of the SSH key for the Redis server"
  value       = hcloud_ssh_key.redis.name
}

output "redis_ssh_key_password" {
  description = "Password for the SSH key for the Redis server"
  value       = random_password.redis_ssh_key_password.result
}

output "control_plane_ips" {
  description = "List of public IPs for control plane nodes"
  value       = hcloud_server.control_plane[*].ipv4_address
}

output "worker_ips" {
  description = "List of public IPs for worker nodes"
  value       = hcloud_server.worker[*].ipv4_address
}

output "db_ip" {
  description = "Private IP for the database server"
  value       = hcloud_server.db.ipv4_address
}

output "redis_ip" {
  description = "Private IP for the Redis server"
  value       = hcloud_server.redis.ipv4_address
}
