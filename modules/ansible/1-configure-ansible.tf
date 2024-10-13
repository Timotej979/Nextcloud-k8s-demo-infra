# Create the inventory file for CLI usage if needed
resource "local_file" "control_plane_inventory" {
  filename = "${path.module}/inventory/inventory.ini"
  content  = templatefile("${path.module}/templates/inventory.tpl", {
    # Control plane nodes
    control_plane_ips           = var.control_plane_ips
    control_plane_ssh_key_name  = var.control_plane_ssh_key_name
    control_plane_ssh_key_password = var.control_plane_ssh_key_password
    # Worker nodes
    worker_ips              = var.worker_ips
    worker_ssh_key_name     = var.worker_ssh_key_name
    worker_ssh_key_password = var.worker_ssh_key_password
    # Database server
    db_ip              = var.db_ip
    db_ssh_key_name    = var.db_ssh_key_name
    db_ssh_key_password = var.db_ssh_key_password
    # Redis server
    redis_ip              = var.redis_ip
    redis_ssh_key_name    = var.redis_ssh_key_name
    redis_ssh_key_password = var.redis_ssh_key_password
  })
}

# Create ansible groups
resource "ansible_group" "control_plane" {
  name = "control_plane"
}

resource "ansible_group" "workers" {
  name = "workers"
}

resource "ansible_group" "db" {
  name = "db"
}

resource "ansible_group" "redis" {
  name = "redis"
}

# Create the control plane hosts
resource "ansible_host" "control_plane" {
  count = length(var.control_plane_ips)
  name  = "${var.control_plane_ips[count.index]}"
  groups = [ "control_plane" ]
  variables = {
    ansible_host = var.control_plane_ips[count.index]
    ansible_user = "root"
    ansible_ssh_private_key_file = var.control_plane_ssh_key_name
    ansible_ssh_pass = var.control_plane_ssh_key_password
  }
}

# Create the worker hosts
resource "ansible_host" "workers" {
  count = length(var.worker_ips)
  name  = "${var.worker_ips[count.index]}"
  groups = [ "workers" ]
  variables = {
    ansible_host = var.worker_ips[count.index]
    ansible_user = "root"
    ansible_ssh_private_key_file = var.worker_ssh_key_name
    ansible_ssh_pass = var.worker_ssh_key_password
  }
}

# Create the database server host
resource "ansible_host" "db" {
  name  = "db"
  groups = [ "db" ]
  variables = {
    ansible_host = var.db_ip
    ansible_user = "root"
    ansible_ssh_private_key_file = var.db_ssh_key_name
    ansible_ssh_pass = var.db_ssh_key_password
  }
}

# Create the Redis server host
resource "ansible_host" "redis" {
  name  = "redis"
  groups = [ "redis" ]
  variables = {
    ansible_host = var.redis_ip
    ansible_user = "root"
    ansible_ssh_private_key_file = var.redis_ssh_key_name
    ansible_ssh_pass = var.redis_ssh_key_password
  }
}