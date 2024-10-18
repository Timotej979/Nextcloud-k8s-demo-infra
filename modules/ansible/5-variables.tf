# Public subnet CIDR
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}

# Control plane IPs
variable "control_plane_ips" {
  description = "List of public IPs for control plane nodes"
  type        = list(string)
}

# Worker IPs
variable "worker_ips" {
  description = "List of public IPs for worker nodes"
  type        = list(string)
}

# Database internal IP
variable "db_internal_ip" {
  description = "Private IP for the database server"
  type        = string
}

# Redis internal IP
variable "redis_internal_ip" {
  description = "Private IP for the Redis server"
  type        = string
}

# COntrol plane SSH configuration
variable "control_plane_ssh_key_name" {
  description = "Name of the SSH key for the control plane nodes"
  type        = string
}

variable "control_plane_ssh_key_path" {
  description = "Path to the SSH key for the control plane nodes"
  type        = string
}

# Worker SSH configuration
variable "worker_ssh_key_name" {
  description = "Name of the SSH key for the worker nodes"
  type        = string
}

variable "worker_ssh_key_path" {
  description = "Path to the SSH key for the worker nodes"
  type        = string
}

# Database SSH configuration
variable "db_ssh_key_name" {
  description = "Name of the SSH key for the database server"
  type        = string
}

variable "db_ssh_key_path" {
  description = "Path to the SSH key for the database server"
  type        = string
}

# Database root password
variable "db_server_root_password" {
  description = "Root password for the database server"
  type        = string
}

# Redis SSH configuration
variable "redis_ssh_key_name" {
  description = "Name of the SSH key for the Redis server"
  type        = string
}

variable "redis_ssh_key_path" {
  description = "Path to the SSH key for the Redis server"
  type        = string
}

# Redis root password
variable "redis_server_root_password" {
  description = "Root password for the Redis server"
  type        = string
}