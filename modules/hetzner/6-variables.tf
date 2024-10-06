variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  sensitive   = true
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = <<EOT
  The environment for the infrastructure. 
  Different environments have different deletion protection settings:

  - "prod": Production environment with deletion protection enabled (delete_protection = true).
  - "stage" or others: Staging or other environments with deletion protection disabled (delete_protection = false).
  EOT
  type        = string
}

variable "ssh_key_name" {
  description = "Name of the SSH key to use for the servers"
  type        = string
}

variable "ssh_key_passphrase" {
  description = "Passphrase for the SSH key"
  type        = string
  sensitive   = true
}

variable "network_zone" {
  description = "Network zone for the subnets: 'eu-central' or 'eu-west', default is 'eu-central'"
  type        = string
  default     = "eu-central"
}

variable "vpc_net_cidr" {
  description = "CIDR range for the VPC network"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR range for the public subnet (frontend)"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_db_subnet_cidr" {
  type        = string
  default     = "10.0.2.0/24"
  description = "CIDR range for the private database subnet"
}

variable "private_redis_subnet_cidr" {
  type        = string
  default     = "10.0.3.0/24"
  description = "CIDR range for the private Redis subnet"
}

variable "num_control_plane_nodes" {
  description = "Number of control plane nodes for the Kubernetes cluster"
  type        = number
  default     = 1
  validation {
    condition     = var.num_control_plane_nodes <= 3
    error_message = "The maximum number of control plane nodes is 3 for stable control sepcified by the Kubernetes project."
  }
}

variable "num_worker_nodes" {
  description = "Number of worker nodes for the Kubernetes cluster"
  type        = number
  default     = 2
}

variable "server_image" {
  description = "Server image for the Kubernetes nodes"
  type        = string
  default     = "ubuntu-20.04"
}

variable "server_type" {
  description = "Server type for the Kubernetes nodes"
  type        = string
  default     = "cx22"
}

variable "server_location" {
  description = "Server location for the Kubernetes nodes"
  type        = string
  default     = "nbg1"
}


