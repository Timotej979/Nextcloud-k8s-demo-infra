output "kubeconfig_path" {
  value = pathexpand(module.ansible_automation.kubeconfig_path)
}

output "nextcloud_db_password" {
  value = module.ansible_automation.postgresql_password
  sensitive = true
}

output "nextcloud_redis_password" {
  value = module.ansible_automation.redis_password
  sensitive = true
}