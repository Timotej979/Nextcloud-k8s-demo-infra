# Create a random password for the Nextcloud admin user
resource "random_password" "nextcloud_admin_password" {
  length  = 32
  special = false
}

# Create the namespace for Nextcloud
resource "kubernetes_namespace" "nextcloud" {
  metadata {
    name = "nextcloud-demo"
  }
}

# Helm chart deployment for Nextcloud
resource "helm_release" "nextcloud" {
  name       = "nextcloud-demo"
  chart      = "nextcloud"
  namespace  = "nextcloud-demo"
  repository = "https://nextcloud.github.io/helm/"
  version    = var.nextcloud_chart_version

  # Values passed to the Helm chart
  values = [
    <<EOF
nextcloud:
  username: nextcloud
  password: ${random_password.nextcloud_admin_password.result}


  database:
    type: postgresql
    host: ${var.postgresql_host}
    port: ${var.postgresql_port}
    user: ${var.postgresql_username}
    password: ${var.postgresql_password}
    database: ${var.postgresql_database}

  redis:
    host: ${var.redis_host}
    port: ${var.redis_port}
    password: ${var.redis_password}

persistence:
  enabled: true
  storageClass: "local-path"
    size: 1Gi

EOF
  ]

  # Ensure the Nextcloud namespace exists
  depends_on = [kubernetes_namespace.nextcloud]
}

