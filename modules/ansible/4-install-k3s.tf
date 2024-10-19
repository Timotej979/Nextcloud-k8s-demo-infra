# Create a k3s installation playbook file
resource "local_sensitive_file" "install_k3s" {
  filename = "${path.module}/playbooks/install_k3s.yml"
  content = templatefile("${path.module}/templates/install_k3s.tpl", {
    control_plane_ip = var.control_plane_ips[0]
  })
}

# Execute the playbook
resource "null_resource" "execute_k3s_playbook" {
  triggers = {
    playbook_id = local_sensitive_file.install_k3s.content
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/inventory/inventory.ini ${path.module}/playbooks/install_k3s.yml"
  }
  
  depends_on = [ local_sensitive_file.ansible_inventory,
                 local_sensitive_file.install_k3s, 
                 local_sensitive_file.generate_ssh_config,
                 null_resource.execute_postgre_playbook, 
                 null_resource.execute_redis_playbook ]  
}