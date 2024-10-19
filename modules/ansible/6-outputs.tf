output "kubeconfig_path" {
  value = "~/.kube/nextcloud_demo_kubeconfig"
}

output "postgresql_password" {
  value = random_password.db_application_user_password.result
}

output "redis_password" {
  value = random_password.redis_application_user_password.result
}