variable "control_plane_ips" {
  description = "List of public IPs for control plane nodes"
  type        = list(string)
}

variable "worker_ips" {
  description = "List of public IPs for worker nodes"
  type        = list(string)
}

variable "db_ip" {
  description = "Private IP for the database server"
  type        = string
}

variable "redis_ip" {
  description = "Private IP for the Redis server"
  type        = string
}

variable "control_plane_ssh_key_name" {
  description = "Name of the SSH key for the control plane nodes"
  type        = string
}

variable "control_plane_ssh_key_password" {
  description = "Password for the SSH key for the control plane nodes"
  type        = string
  sensitive   = true
}

variable "worker_ssh_key_name" {
  description = "Name of the SSH key for the worker nodes"
  type        = string
}

variable "worker_ssh_key_password" {
  description = "Password for the SSH key for the worker nodes"
  type        = string
  sensitive   = true
}

variable "db_ssh_key_name" {
  description = "Name of the SSH key for the database server"
  type        = string
}

variable "db_ssh_key_password" {
  description = "Password for the SSH key for the database server"
  type        = string
  sensitive   = true
}

variable "redis_ssh_key_name" {
  description = "Name of the SSH key for the Redis server"
  type        = string
}

variable "redis_ssh_key_password" {
  description = "Password for the SSH key for the Redis server"
  type        = string
  sensitive   = true
}