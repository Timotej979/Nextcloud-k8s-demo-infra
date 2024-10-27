# Cluster Role for cert-manager
resource "kubernetes_cluster_role" "cert_manager" {
  metadata {
    name = "cert-manager"
  }

  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
  }
}

# Cluster Role Binding for cert-manager
resource "kubernetes_cluster_role_binding" "cert_manager" {
  metadata {
    name = "cert-manager"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.cert_manager.metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = "cert-manager"
    namespace = "cert-manager"
  }
}

# Create the cert-manager Helm release
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  namespace  = "cert-manager"

  create_namespace = true

  set {
    name  = "installCRDs"
    value = "true"
  }

  depends_on = [ kubernetes_cluster_role.cert_manager, kubernetes_cluster_role_binding.cert_manager ]
}

# Create the YAML file from the template
resource "local_file" "letsencrypt_prod" {
  filename = "${path.module}/manifests/letsencrypt-prod.yml"
  content  = templatefile("${path.module}/templates/letsencrypt-prod.tpl", {
    letsencrypt_emal = var.letsencrypt_email
  })
}

resource "kubectl_manifest" "letsencrypt_prod" {
  yaml_body = local_file.letsencrypt_prod.content
  depends_on = [ helm_release.cert_manager ]
}
