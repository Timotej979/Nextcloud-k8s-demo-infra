# Create the inventory file for CLI usage if needed
resource "local_sensitive_file" "ansible_inventory" {
  filename = "${path.module}/inventory/inventory.ini"
  content  = templatefile("${path.module}/templates/inventory.tpl", {
    # Control plane nodes
    control_plane_ip          = var.control_plane_ip
    control_plane_ssh_key_path = var.control_plane_ssh_key_path
    # Worker nodes
    worker_ips          = var.worker_ips
    worker_ssh_key_path = var.worker_ssh_key_path
    # Database server
    db_ip            = var.db_internal_ip
    db_ssh_key_path  = var.db_ssh_key_path
    db_root_password = var.db_server_root_password
    # Redis server
    redis_ip            = var.redis_internal_ip
    redis_ssh_key_path  = var.redis_ssh_key_path
    redis_root_password = var.redis_server_root_password
  })
}

# Create the SSH config file
resource "local_sensitive_file" "generate_ssh_config" {
  filename = pathexpand("~/.ssh/config")
  content = templatefile("${path.module}/templates/ssh_config.tpl", {
    control_plane_ip = var.control_plane_ip
    control_plane_ssh_key_path = var.control_plane_ssh_key_path
    worker_ips = var.worker_ips
    worker_ssh_key_path = var.worker_ssh_key_path
    db_ip = var.db_internal_ip
    db_ssh_key_path = var.db_ssh_key_path
    redis_ip = var.redis_internal_ip
    redis_ssh_key_path = var.redis_ssh_key_path
  })
}