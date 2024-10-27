## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | >= 1.7.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.15 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | ~> 2.0 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | >= 1.7.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.15 |
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.letsencrypt_prod](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_cluster_role.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role) | resource |
| [kubernetes_cluster_role_binding.cert_manager](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/cluster_role_binding) | resource |
| [kubernetes_manifest.hcloud_ccm_deployment](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_secret.hcloud_ccm_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |
| [local_file.ccm_deployment](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.letsencrypt_prod](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.nginx_values](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_cidr"></a> [cluster\_cidr](#input\_cluster\_cidr) | The CIDR block for the Kubernetes cluster | `string` | n/a | yes |
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | The Hetzner Cloud API token | `string` | n/a | yes |
| <a name="input_ingress_lb_name"></a> [ingress\_lb\_name](#input\_ingress\_lb\_name) | Name of the ingress load balancer | `string` | n/a | yes |
| <a name="input_kubeconfig_path"></a> [kubeconfig\_path](#input\_kubeconfig\_path) | The path to the kubeconfig file | `string` | n/a | yes |
| <a name="input_letsencrypt_email"></a> [letsencrypt\_email](#input\_letsencrypt\_email) | The email address for Let's Encrypt | `string` | `"nextcloud-demo@demo.net"` | no |
| <a name="input_server_location"></a> [server\_location](#input\_server\_location) | The location of the Hetzner Cloud servers | `string` | n/a | yes |
| <a name="input_vpc_network_id"></a> [vpc\_network\_id](#input\_vpc\_network\_id) | The ID of the Hetzner Cloud network | `string` | n/a | yes |

## Outputs

No outputs.
