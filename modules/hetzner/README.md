## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.45 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_firewall.control_plane_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.db_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.redis_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.worker_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_network.vpc](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network) | resource |
| [hcloud_network_subnet.private_db](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.private_redis](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_network_subnet.public](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/network_subnet) | resource |
| [hcloud_server.control_plane](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server.db](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server.redis](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_server.worker](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/server) | resource |
| [hcloud_ssh_key.cluster_controls](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [hcloud_ssh_key.cluster_workers](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [hcloud_ssh_key.db](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [hcloud_ssh_key.redis](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/ssh_key) | resource |
| [external_external.cluster_control_key](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.cluster_worker_key](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.db_key](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |
| [external_external.redis_key](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | The environment for the infrastructure. <br/>  Different environments have different deletion protection settings:<br/><br/>  - "prod": Production environment with deletion protection enabled (delete\_protection = true).<br/>  - "stage" or others: Staging or other environments with deletion protection disabled (delete\_protection = false). | `string` | n/a | yes |
| <a name="input_hcloud_token"></a> [hcloud\_token](#input\_hcloud\_token) | Hetzner Cloud API token | `string` | n/a | yes |
| <a name="input_network_zone"></a> [network\_zone](#input\_network\_zone) | Network zone for the subnets: 'eu-central' or 'eu-west', default is 'eu-central' | `string` | `"eu-central"` | no |
| <a name="input_num_control_plane_nodes"></a> [num\_control\_plane\_nodes](#input\_num\_control\_plane\_nodes) | Number of control plane nodes for the Kubernetes cluster | `number` | `1` | no |
| <a name="input_num_worker_nodes"></a> [num\_worker\_nodes](#input\_num\_worker\_nodes) | Number of worker nodes for the Kubernetes cluster | `number` | `2` | no |
| <a name="input_private_db_subnet_cidr"></a> [private\_db\_subnet\_cidr](#input\_private\_db\_subnet\_cidr) | CIDR range for the private database subnet | `string` | `"10.0.2.0/24"` | no |
| <a name="input_private_redis_subnet_cidr"></a> [private\_redis\_subnet\_cidr](#input\_private\_redis\_subnet\_cidr) | CIDR range for the private Redis subnet | `string` | `"10.0.3.0/24"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR range for the public subnet (frontend) | `string` | `"10.0.1.0/24"` | no |
| <a name="input_recreate_ssh_keys"></a> [recreate\_ssh\_keys](#input\_recreate\_ssh\_keys) | Recreate the SSH keys for the infrastructure, can be used to rotate the SSH keys (Valid values: 0 or 1) | `number` | `1` | no |
| <a name="input_server_image"></a> [server\_image](#input\_server\_image) | Server image for the Kubernetes nodes, check the Hetzner Cloud API for available images | `string` | `"ubuntu-20.04"` | no |
| <a name="input_server_location"></a> [server\_location](#input\_server\_location) | Server location for the Kubernetes nodes, check the Hetzner Cloud API for available locations | `string` | `"nbg1"` | no |
| <a name="input_server_type"></a> [server\_type](#input\_server\_type) | Server type for the Kubernetes nodes, check the Hetzner Cloud API for available types | `string` | `"cx22"` | no |
| <a name="input_ssh_key_passphrase"></a> [ssh\_key\_passphrase](#input\_ssh\_key\_passphrase) | Passphrase for the SSH keys used in the infrastructure | `string` | n/a | yes |
| <a name="input_vpc_net_cidr"></a> [vpc\_net\_cidr](#input\_vpc\_net\_cidr) | CIDR range for the VPC network | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_control_plane_ips"></a> [control\_plane\_ips](#output\_control\_plane\_ips) | List of public IPs for control plane nodes |
| <a name="output_control_plane_ssh_key_name"></a> [control\_plane\_ssh\_key\_name](#output\_control\_plane\_ssh\_key\_name) | Name of the SSH key for the control plane nodes |
| <a name="output_db_ip"></a> [db\_ip](#output\_db\_ip) | Private IP for the database server |
| <a name="output_db_ssh_key_name"></a> [db\_ssh\_key\_name](#output\_db\_ssh\_key\_name) | Name of the SSH key for the database server |
| <a name="output_redis_ip"></a> [redis\_ip](#output\_redis\_ip) | Private IP for the Redis server |
| <a name="output_redis_ssh_key_name"></a> [redis\_ssh\_key\_name](#output\_redis\_ssh\_key\_name) | Name of the SSH key for the Redis server |
| <a name="output_worker_ips"></a> [worker\_ips](#output\_worker\_ips) | List of public IPs for worker nodes |
| <a name="output_worker_ssh_key_name"></a> [worker\_ssh\_key\_name](#output\_worker\_ssh\_key\_name) | Name of the SSH key for the worker nodes |
