variable "kubeconfig_path" {
  description = "The path to the kubeconfig file"
  type        = string
}

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
}

variable "postgresql_host" {
  description = "The hostname of the PostgreSQL server"
  type        = string
}

variable "postgresql_port" {
  description = "The port of the PostgreSQL server"
  type        = number
}

variable "postgresql_username" {
  description = "The username to connect to the PostgreSQL server"
  type        = string
}

variable "postgresql_password" {
  description = "The password to connect to the PostgreSQL server"
  type        = string
}

variable "postgresql_database" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "redis_host" {
  description = "The hostname of the Redis server"
  type        = string
}

variable "redis_port" {
  description = "The port of the Redis server"
  type        = number
}

variable "redis_password" {
  description = "The password to connect to the Redis server"
  type        = string
}