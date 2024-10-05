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