module "configure_cluster" {
  source = "../../../modules/k3s"

  # General configuration
  kubeconfig_path = data.terraform_remote_state.ansible.outputs.kubeconfig_path
  nextcloud_domain = var.nextcloud_domain
  cert_email       = var.cert_email
  nextcloud_chart_version = var.nextcloud_chart_version
  
  # PostgreSQL configuration
  postgresql_host         = data.terraform_remote_state.hetzner_infrastructure.outputs.db_internal_ip
  postgresql_port         = 5432
  postgresql_username     = "nextcloud"
  postgresql_password     = data.terraform_remote_state.ansible.outputs.nextcloud_db_password
  postgresql_database     = "nextcloud"

  # Redis configuration
  redis_host             = data.terraform_remote_state.hetzner_infrastructure.outputs.redis_internal_ip
  redis_port             = 6379
  redis_password         = data.terraform_remote_state.ansible.outputs.nextcloud_redis_password
}