# Random passwords for SSH keys
resource "random_password" "cluster_worker_ssh_key_password" {
  length           = 32
  special          = false
}

resource "random_password" "cluster_control_ssh_key_password" {
  length           = 32
  special          = false
}

resource "random_password" "db_ssh_key_password" {
  length           = 32
  special          = false
}

resource "random_password" "redis_ssh_key_password" {
  length           = 32
  special          = false
}

# External data sources for SSH keys
data "external" "cluster_worker_key" {
  program   = ["bash",
               "${path.module}/generate_ssh_key.sh", "nextcloud_demo_cluster_worker",
                random_password.cluster_worker_ssh_key_password.result,
                var.recreate_ssh_keys]
}

data "external" "cluster_control_key" {
  program = ["bash",
             "${path.module}/generate_ssh_key.sh",
             "nextcloud_demo_cluster_control",
             random_password.cluster_control_ssh_key_password.result,
             var.recreate_ssh_keys]
}

data "external" "db_key" {
  program = ["bash",
             "${path.module}/generate_ssh_key.sh",
             "nextcloud_demo_db",
             random_password.db_ssh_key_password.result,
             var.recreate_ssh_keys]
}

data "external" "redis_key" {
  program = ["bash",
             "${path.module}/generate_ssh_key.sh",
             "nextcloud_demo_redis",
             random_password.redis_ssh_key_password.result,
             var.recreate_ssh_keys]
}

# Create an SSH key resource for the Cluster worker nodes
resource "hcloud_ssh_key" "cluster_workers" {
  name       = "${var.environment}-${var.project}-cluster-workers"
  public_key = data.external.cluster_worker_key.result["public_key"]
  depends_on = [ data.external.cluster_worker_key ]
}

# Create an SSH key resource for the Cluster control plane
resource "hcloud_ssh_key" "cluster_controls" {
  name       = "${var.environment}-${var.project}-cluster-controls"
  public_key = data.external.cluster_control_key.result["public_key"]
  depends_on = [ data.external.cluster_control_key ]
}

# Create an SSH key resource for the DB
resource "hcloud_ssh_key" "db" {
  name       = "${var.environment}-${var.project}-db"
  public_key = data.external.db_key.result["public_key"]
  depends_on = [ data.external.db_key ]
}

# Create an SSH key resource for the Redis
resource "hcloud_ssh_key" "redis" {
  name       = "${var.environment}-${var.project}-redis"
  public_key = data.external.redis_key.result["public_key"]
  depends_on = [ data.external.redis_key ]
}
