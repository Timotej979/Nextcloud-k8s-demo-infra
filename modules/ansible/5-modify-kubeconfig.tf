resource "null_resource" "update_kubeconfig" {
  provisioner "local-exec" {
    command = <<EOT
      # Backup the existing kubeconfig file
      cp ~/.kube/nextcloud_demo_kubeconfig ~/.kube/nextcloud_demo_kubeconfig.bak
      # Replace the old IP with the new one in the 'server' line of the kubeconfig
      sed -i 's|server: https://.*:6443|server: https://${var.control_plane_ips[0]}:6443|' ~/.kube/nextcloud_demo_kubeconfig
    EOT
  }
  depends_on = [ null_resource.execute_k3s_playbook ]
}
