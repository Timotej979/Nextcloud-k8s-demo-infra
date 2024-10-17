# Create root password for the database
resource "random_password" "db_root_password" {
  length           = 32
  special          = false
}

# Create the password for cluster user access
resource "random_password" "db_cluster_user_password" {
  length           = 32
  special          = false
}

# Create a password for application user access
resource "random_password" "db_application_user_password" {
  length           = 32
  special          = false
}

# This file is responsible for installing PostgreSQL on the target host
resource "ansible_playbook" "postgres" {
  playbook   = "${path.module}/playbooks/install_postgre.yml"
  name       = var.db_internal_ip
  replayable = true

  extra_vars = {
    root_user_password   = random_password.db_root_password.result
    nextcloud_password   = random_password.db_application_user_password.result
    cluster_password     = random_password.db_cluster_user_password.result
  }
}

# Execute the playbook
resource "null_resource" "execute_playbook" {
  triggers = {
    playbook_id = ansible_playbook.postgres.id
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/inventory/inventory.ini ${path.module}/playbooks/install_postgre.yml"
  }
  depends_on = [ ansible_playbook.postgres , local_file.control_plane_inventory , local_file.ssh_config ]
}