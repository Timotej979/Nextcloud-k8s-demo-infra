variable "nextcloud_domain" {
  description = "The domain name of the Nextcloud instance"
  type        = string
}

variable "cert_email" {
  description = "The email address to use for the SSL certificate"
  type        = string
}

variable "nextcloud_chart_version" {
  description = "The version of the Nextcloud Helm chart to deploy"
  type        = string
  default     = "6.1.0"
}