variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  sensitive   = true
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
  default     = "stage"
}

variable "project" {
  description = "Project name"
  type        = string
  default     = "nextcloud-demo"
}

variable "recreate_ssh_keys" {
  description = "Recreate the SSH keys for the infrastructure, can be used to rotate the SSH keys (Valid values: 0 or 1)"
  type        = number
  default     = 1
  validation {
    condition     = var.recreate_ssh_keys >= 0 && var.recreate_ssh_keys <= 1
    error_message = "Valid values are 0 or 1."
  }
}

variable "network_zone" {
  description = "Network zone for the subnets (Check the Hetzner Cloud documentation for the available zones)"
  type        = string
  default     = "eu-central"
  
}