# Create the ingress resource for the nextcloud service
resource "kubernetes_manifest" "nextcloud_ingress" {
  manifest = {
    apiVersion = "networking.k8s.io/v1"
    kind       = "Ingress"
    metadata = {
      name      = "nextcloud-ingress"
      namespace = "nextcloud"
      annotations = {
        "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
        "nginx.ingress.kubernetes.io/use-regex"      = "true"
        "cert-manager.io/cluster-issuer"             = "letsencrypt"
      }
    }
    spec = {
      ingressClassName = "nginx"
      tls = [
        {
          hosts      = [var.nextcloud_domain]
          secretName = "nextcloud-tls"
        }
      ]
      rules = [
        {
          host = var.nextcloud_domain
          http = {
            paths = [
              {
                path     = "/(.*)"
                pathType = "ImplementationSpecific"
                backend  = {
                  service = {
                    name = "nextcloud"
                    port = {
                      number = 80
                    }
                  }
                }
              }
            ]
          }
        }
      ]
    }
  }
  depends_on = [ helm_release.cert_manager, helm_release.nginx_ingress ]
}
