# Create root password for the database
resource "random_password" "db_admin_password" {
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

resource "local_sensitive_file" "install_postgre" {
  filename = "${path.module}/playbooks/install_postgre.yml"
  content = templatefile("${path.module}/templates/install_postgre.tpl", {
    public_subnet_cidr  = var.public_subnet_cidr
    admin_user_password = random_password.db_admin_password.result
    nextcloud_password  = random_password.db_application_user_password.result
    cluster_password    = random_password.db_cluster_user_password.result
  })
}

# Execute the playbook
resource "null_resource" "execute_postgre_playbook" {
  triggers = {
    playbook_id = local_sensitive_file.install_postgre.content
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/inventory/inventory.ini ${path.module}/playbooks/install_postgre.yml"
  }
  depends_on = [ local_sensitive_file.ansible_inventory, local_sensitive_file.install_postgre, local_sensitive_file.generate_ssh_config ]
}