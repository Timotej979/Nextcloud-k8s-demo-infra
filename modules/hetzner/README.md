## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_hcloud"></a> [hcloud](#requirement\_hcloud) | ~> 1.45 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | n/a |
| <a name="provider_hcloud"></a> [hcloud](#provider\_hcloud) | ~> 1.45 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [hcloud_firewall.control_plane_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.db_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.redis_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_firewall.worker_firewall](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/firewall) | resource |
| [hcloud_load_balancer.ingress](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer) | resource |
| [hcloud_load_balancer_network.ingress_network](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_network) | resource |
| [hcloud_load_balancer_target.ingress_target](https://registry.terraform.io/providers/hetznercloud/hcloud/latest/docs/resources/load_balancer_target) | resource |
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
| [random_password.control_plane_root_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.db_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.redis_pass](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.workers_root_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
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
| <a name="input_num_worker_nodes"></a> [num\_worker\_nodes](#input\_num\_worker\_nodes) | Number of worker nodes for the Kubernetes cluster | `number` | `2` | no |
| <a name="input_private_db_subnet_cidr"></a> [private\_db\_subnet\_cidr](#input\_private\_db\_subnet\_cidr) | CIDR range for the private database subnet | `string` | `"10.0.2.0/24"` | no |
| <a name="input_private_redis_subnet_cidr"></a> [private\_redis\_subnet\_cidr](#input\_private\_redis\_subnet\_cidr) | CIDR range for the private Redis subnet | `string` | `"10.0.3.0/24"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR range for the public subnet (frontend) | `string` | `"10.0.1.0/24"` | no |
| <a name="input_recreate_ssh_keys"></a> [recreate\_ssh\_keys](#input\_recreate\_ssh\_keys) | Recreate the SSH keys for the infrastructure, can be used to rotate the SSH keys (Valid values: 0 or 1) | `number` | `1` | no |
| <a name="input_server_image"></a> [server\_image](#input\_server\_image) | Server image for the Kubernetes nodes, check the Hetzner Cloud API for available images | `string` | `"ubuntu-20.04"` | no |
| <a name="input_server_location"></a> [server\_location](#input\_server\_location) | Server location for the Kubernetes nodes, check the Hetzner Cloud API for available locations | `string` | `"nbg1"` | no |
| <a name="input_server_type"></a> [server\_type](#input\_server\_type) | Server type for the Kubernetes nodes, check the Hetzner Cloud API for available types | `string` | `"cx22"` | no |
| <a name="input_vpc_net_cidr"></a> [vpc\_net\_cidr](#input\_vpc\_net\_cidr) | CIDR range for the VPC network | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_control_plane_ip"></a> [control\_plane\_ip](#output\_control\_plane\_ip) | IP of the control plane node |
| <a name="output_control_plane_root_password"></a> [control\_plane\_root\_password](#output\_control\_plane\_root\_password) | Root password for the control plane nodes |
| <a name="output_control_plane_ssh_key_name"></a> [control\_plane\_ssh\_key\_name](#output\_control\_plane\_ssh\_key\_name) | Name of the SSH key for the control plane nodes |
| <a name="output_control_plane_ssh_key_path"></a> [control\_plane\_ssh\_key\_path](#output\_control\_plane\_ssh\_key\_path) | Path to the SSH key for the control plane nodes |
| <a name="output_db_internal_ip"></a> [db\_internal\_ip](#output\_db\_internal\_ip) | Private IP for the database server |
| <a name="output_db_ip"></a> [db\_ip](#output\_db\_ip) | Private IP for the database server |
| <a name="output_db_server_root_password"></a> [db\_server\_root\_password](#output\_db\_server\_root\_password) | Root password for the database server |
| <a name="output_db_ssh_key_name"></a> [db\_ssh\_key\_name](#output\_db\_ssh\_key\_name) | Name of the SSH key for the database server |
| <a name="output_db_ssh_key_path"></a> [db\_ssh\_key\_path](#output\_db\_ssh\_key\_path) | Path to the SSH key for the database server |
| <a name="output_ingress_lb_ip"></a> [ingress\_lb\_ip](#output\_ingress\_lb\_ip) | IP address of the ingress load balancer |
| <a name="output_ingress_lb_name"></a> [ingress\_lb\_name](#output\_ingress\_lb\_name) | Name of the ingress load balancer |
| <a name="output_public_subnet_cidr"></a> [public\_subnet\_cidr](#output\_public\_subnet\_cidr) | CIDR block for the public subnet |
| <a name="output_redis_internal_ip"></a> [redis\_internal\_ip](#output\_redis\_internal\_ip) | Private IP for the database server |
| <a name="output_redis_ip"></a> [redis\_ip](#output\_redis\_ip) | Private IP for the Redis server |
| <a name="output_redis_server_root_password"></a> [redis\_server\_root\_password](#output\_redis\_server\_root\_password) | Root password for the Redis server |
| <a name="output_redis_ssh_key_name"></a> [redis\_ssh\_key\_name](#output\_redis\_ssh\_key\_name) | Name of the SSH key for the Redis server |
| <a name="output_redis_ssh_key_path"></a> [redis\_ssh\_key\_path](#output\_redis\_ssh\_key\_path) | Path to the SSH key for the Redis server |
| <a name="output_server_location"></a> [server\_location](#output\_server\_location) | The location of the Hetzner Cloud servers |
| <a name="output_vpc_network_id"></a> [vpc\_network\_id](#output\_vpc\_network\_id) | The ID of the Hetzner Cloud network |
| <a name="output_worker_ips"></a> [worker\_ips](#output\_worker\_ips) | List of public IPs for worker nodes |
| <a name="output_worker_root_password"></a> [worker\_root\_password](#output\_worker\_root\_password) | Root password for the worker nodes |
| <a name="output_worker_ssh_key_name"></a> [worker\_ssh\_key\_name](#output\_worker\_ssh\_key\_name) | Name of the SSH key for the worker nodes |
| <a name="output_worker_ssh_key_path"></a> [worker\_ssh\_key\_path](#output\_worker\_ssh\_key\_path) | Path to the SSH key for the worker nodes |
