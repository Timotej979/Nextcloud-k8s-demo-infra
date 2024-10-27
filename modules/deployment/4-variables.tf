variable "hcloud_token" {
  description = "The Hetzner Cloud API token"
  type        = string
  sensitive   = true
}

variable "kubeconfig_path" {
  description = "The path to the kubeconfig file"
  type        = string
}

variable "letsencrypt_email" {
  description = "The email address for Let's Encrypt"
  type        = string
  default     = "nextcloud-demo@demo.net"
}

####################################################################################################

variable "vpc_network_id" {
  description = "The ID of the Hetzner Cloud network"
  type        = string
}

variable "cluster_cidr" {
  description = "The CIDR block for the Kubernetes cluster"
  type        = string
}

variable "ingress_lb_name" {
  description = "Name of the ingress load balancer"
  type        = string
}

variable "server_location" {
  description = "The location of the Hetzner Cloud servers"
  type        = string
}