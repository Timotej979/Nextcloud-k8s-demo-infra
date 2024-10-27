# Create a password for application user access
resource "random_password" "redis_application_user_password" {
  length  = 32
  special = false
}

# Create a Redis installation playbook file
resource "local_sensitive_file" "install_redis" {
  filename = "${path.module}/playbooks/install_redis.yml"
  content = templatefile("${path.module}/templates/install_redis.tpl", {
    public_subnet_cidr   = var.public_subnet_cidr
    redis_password       = random_password.redis_application_user_password.result
  })
}

# Execute the playbook
resource "null_resource" "execute_redis_playbook" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/inventory/inventory.ini ${path.module}/playbooks/install_redis.yml"
  }
  
  depends_on = [ local_sensitive_file.ansible_inventory, local_sensitive_file.install_redis, local_sensitive_file.generate_ssh_config ]
}