# Create a k3s installation playbook file
resource "local_sensitive_file" "install_k3s" {
  filename = "${path.module}/playbooks/install_k3s.yml"
  content = templatefile("${path.module}/templates/install_k3s.tpl", {
    k3s_version      = var.k3s_version
    cluster_cidr     = var.cluster_cidr
    control_plane_ip = var.control_plane_ip
  })
}

# Execute the playbook
resource "null_resource" "execute_k3s_playbook" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -i ${path.module}/inventory/inventory.ini ${path.module}/playbooks/install_k3s.yml"
  }
  depends_on = [ local_sensitive_file.ansible_inventory, local_sensitive_file.install_k3s, local_sensitive_file.generate_ssh_config ]
}