variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  sensitive   = true
  type        = string
}

variable "ssh_key_passphrase" {
  description = "Passphrase for the SSH keys used in the infrastructure"
  type        = string
  sensitive   = true
}