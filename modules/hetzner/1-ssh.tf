# Local-exec provisioner to generate SSH key for the Cluster worker nodes
resource "null_resource" "ssh_key_gen_cluster" {
  provisioner "local-exec" {
    command = "${path.module}/generate_ssh_key.sh nextcloud_hetzner_cluster_workers ${var.ssh_key_passphrase}"
  }
}

# Local-exec provisioner to generate SSH key for the Cluster control plane
resource "null_resource" "ssh_key_gen_control_plane" {
  provisioner "local-exec" {
    command = "${path.module}/generate_ssh_key.sh nextcloud_hetzner_cluster_controls ${var.ssh_key_passphrase}"
  }
}

# Local-exec provisioner to generate SSH key for the DB
resource "null_resource" "ssh_key_gen_db" {
  provisioner "local-exec" {
    command = "${path.module}/generate_ssh_key.sh nextcloud_hetzner_db ${var.ssh_key_passphrase}"
  }
}

# Local-exec provisioner to generate SSH key for the Redis
resource "null_resource" "ssh_key_gen_redis" {
  provisioner "local-exec" {
    command = "${path.module}/generate_ssh_key.sh nextcloud_hetzner_redis ${var.ssh_key_passphrase}"
  }
}

# Create an SSH key resource for the Cluster worker nodes
resource "hcloud_ssh_key" "cluster_workers" {
  name       = "${var.environment}-${var.project}-cluster-workers"
  public_key = file("${path.module}/nextcloud_hetzner_cluster_workers.pub")
  depends_on = [ null_resource.ssh_key_gen_cluster ]
}

# Create an SSH key resource for the Cluster control plane
resource "hcloud_ssh_key" "cluster_controls" {
  name       = "${var.environment}-${var.project}-cluster-controls"
  public_key = file("${path.module}/nextcloud_hetzner_cluster_controls.pub")
  depends_on = [ null_resource.ssh_key_gen_control_plane ]
}

# Create an SSH key resource for the DB
resource "hcloud_ssh_key" "db" {
  name       = "${var.environment}-${var.project}-db"
  public_key = file("${path.module}/nextcloud_hetzner_db.pub")
  depends_on = [ null_resource.ssh_key_gen_db ]
}

# Create an SSH key resource for the Redis
resource "hcloud_ssh_key" "redis" {
  name       = "${var.environment}-${var.project}-redis"
  public_key = file("${path.module}/nextcloud_hetzner_redis.pub")
  depends_on = [ null_resource.ssh_key_gen_redis ]
}