# This file is responsible for installing PostgreSQL on the target host
resource "ansible_playbook" "playbook" {
  playbook   = "${path.module}/playbooks/install_postgre.yml"
  name       = ansible_host.db.name
  replayable = true

  extra_vars = {
    nextcloud_password   = random_password.application_user_password.result
    cluster_password     = random_password.cluster_user_password.result
  }
}