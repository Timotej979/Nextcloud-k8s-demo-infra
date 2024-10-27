# Create the YAML file from the template
resource "local_file" "nginx_values" {
  filename = "${path.module}/manifests/nginx-values.yml"
  content  = templatefile("${path.module}/templates/nginx-values.tpl", {
    ingress_lb_name = var.ingress_lb_name
    server_location = var.server_location
    domain_name     = "nxtcloud-demo.duckdns.org"
  })
}


resource "helm_release" "ingress_nginx" {
  name       = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = "ingress-nginx"

  create_namespace = true

  values = [
    file("${path.module}/manifests/nginx-values.yml")
  ]

  depends_on = [ local_file.nginx_values, kubectl_manifest.letsencrypt_prod ]
}


