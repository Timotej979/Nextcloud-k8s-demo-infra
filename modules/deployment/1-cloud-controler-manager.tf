# Create a secret for the Hetzner Cloud Controller Manager
resource "kubernetes_secret" "hcloud_ccm_secret" {
  metadata {
    name      = "hcloud-controller-manager"
    namespace = "kube-system"
  }

  data = {
    token   = var.hcloud_token
    network = var.vpc_network_id
  }
}

# Create the YAML file from the template
resource "local_file" "ccm_deployment" {
  filename = "${path.module}/manifests/ccm-networks.yml"
  content  = templatefile("${path.module}/templates/ccm-networks.tpl", {
    cluster_cidr = var.cluster_cidr
  })
}

# Apply the rendered YAML to Kubernetes
resource "kubernetes_manifest" "hcloud_ccm_deployment" {
  for_each = tomap({ for i, v in split("---", local_file.ccm_deployment.content) : i => v if v != "" })
  manifest = yamldecode(each.value)
  depends_on = [kubernetes_secret.hcloud_ccm_secret, local_file.ccm_deployment]
}
