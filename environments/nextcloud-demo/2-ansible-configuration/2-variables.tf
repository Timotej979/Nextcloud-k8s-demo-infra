variable "cluster_cidr" {
  description = "The CIDR block for the Kubernetes cluster"
  type        = string
  default     = "10.100.0.0/16"
}