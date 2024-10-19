# Install Nginx Ingress Controller
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress"
  chart      = "ingress-nginx/ingress-nginx"
  namespace  = "ingress-basic"
  repository = "https://kubernetes.github.io/ingress-nginx"
  version    = "4.7.1"
  create_namespace = true

  set {
    name  = "controller.replicaCount"
    value = 2
  }

  set {
    name  = "controller.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "controller.admissionWebhooks.patch.nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }

  set {
    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
    value = "/healthz"
  }

  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
}

# Install cert-manager
# Install Cert-Manager
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  chart      = "jetstack/cert-manager"
  namespace  = "ingress-basic"
  repository = "https://charts.jetstack.io"
  version    = "v1.8.0"

  set {
    name  = "installCRDs"
    value = "true"
  }

  set {
    name  = "nodeSelector.kubernetes\\.io/os"
    value = "linux"
  }
}

# Create ClusterIssuer for Let's Encrypt
resource "kubernetes_manifest" "letsencrypt_cluster_issuer" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "ClusterIssuer"
    metadata = {
      name = "letsencrypt"
    }
    spec = {
      acme = {
        server = "https://acme-v02.api.letsencrypt.org/directory"
        email  = var.cert_email
        privateKeySecretRef = {
          name = "letsencrypt"
        }
        solvers = [
          {
            http01 = {
              ingress = {
                class = "nginx"
              }
            }
          }
        ]
      }
    }
  }
  depends_on = [ helm_release.cert_manager ]
}


