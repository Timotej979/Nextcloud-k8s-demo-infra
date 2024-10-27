output "kubeconfig_path" {
  description = "The path to the kubeconfig file"
  value = pathexpand(module.ansible_configuration.kubeconfig_path)
}

output "cluster_cidr" {
  description = "The CIDR block for the Kubernetes cluster"
  value = module.ansible_configuration.cluster_cidr
}

output "nextcloud_db_password" {
  description = "The password for the Nextcloud database user"
  value = module.ansible_configuration.postgresql_password
  sensitive = true
}

output "nextcloud_redis_password" {
  description = "The password for the Nextcloud Redis user"
  value = module.ansible_configuration.redis_password
  sensitive = true
}