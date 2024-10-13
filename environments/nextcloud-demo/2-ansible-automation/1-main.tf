module "ansible_automation" {
  source = "../../../modules/ansible"

  # Ansible variables
  control_plane_ips = data.terraform_remote_state.hetzner_infrastructure.outputs.control_plane_ips
  worker_ips        = data.terraform_remote_state.hetzner_infrastructure.outputs.worker_ips
  db_ip             = data.terraform_remote_state.hetzner_infrastructure.outputs.db_ip
  redis_ip          = data.terraform_remote_state.hetzner_infrastructure.outputs.redis_ip

  # SSH key variables
  control_plane_ssh_key_name  = data.terraform_remote_state.hetzner_infrastructure.outputs.control_plane_ssh_key_name
  control_plane_ssh_key_password = data.terraform_remote_state.hetzner_infrastructure.outputs.control_plane_ssh_key_password
  worker_ssh_key_name          = data.terraform_remote_state.hetzner_infrastructure.outputs.worker_ssh_key_name
  worker_ssh_key_password      = data.terraform_remote_state.hetzner_infrastructure.outputs.worker_ssh_key_password
  db_ssh_key_name              = data.terraform_remote_state.hetzner_infrastructure.outputs.db_ssh_key_name
  db_ssh_key_password          = data.terraform_remote_state.hetzner_infrastructure.outputs.db_ssh_key_password
  redis_ssh_key_name           = data.terraform_remote_state.hetzner_infrastructure.outputs.redis_ssh_key_name
  redis_ssh_key_password       = data.terraform_remote_state.hetzner_infrastructure.outputs.redis_ssh_key_password
}