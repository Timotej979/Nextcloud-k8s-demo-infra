## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_sensitive_file.ansible_inventory](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.generate_ssh_config](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.install_k3s](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.install_postgre](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [local_sensitive_file.install_redis](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/sensitive_file) | resource |
| [null_resource.execute_k3s_playbook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.execute_postgre_playbook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.execute_redis_playbook](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.update_kubeconfig](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.db_admin_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.db_application_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_password.redis_application_user_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_control_plane_ips"></a> [control\_plane\_ips](#input\_control\_plane\_ips) | List of public IPs for control plane nodes | `list(string)` | n/a | yes |
| <a name="input_control_plane_ssh_key_name"></a> [control\_plane\_ssh\_key\_name](#input\_control\_plane\_ssh\_key\_name) | Name of the SSH key for the control plane nodes | `string` | n/a | yes |
| <a name="input_control_plane_ssh_key_path"></a> [control\_plane\_ssh\_key\_path](#input\_control\_plane\_ssh\_key\_path) | Path to the SSH key for the control plane nodes | `string` | n/a | yes |
| <a name="input_db_internal_ip"></a> [db\_internal\_ip](#input\_db\_internal\_ip) | Private IP for the database server | `string` | n/a | yes |
| <a name="input_db_server_root_password"></a> [db\_server\_root\_password](#input\_db\_server\_root\_password) | Root password for the database server | `string` | n/a | yes |
| <a name="input_db_ssh_key_name"></a> [db\_ssh\_key\_name](#input\_db\_ssh\_key\_name) | Name of the SSH key for the database server | `string` | n/a | yes |
| <a name="input_db_ssh_key_path"></a> [db\_ssh\_key\_path](#input\_db\_ssh\_key\_path) | Path to the SSH key for the database server | `string` | n/a | yes |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR block for the public subnet | `string` | n/a | yes |
| <a name="input_redis_internal_ip"></a> [redis\_internal\_ip](#input\_redis\_internal\_ip) | Private IP for the Redis server | `string` | n/a | yes |
| <a name="input_redis_server_root_password"></a> [redis\_server\_root\_password](#input\_redis\_server\_root\_password) | Root password for the Redis server | `string` | n/a | yes |
| <a name="input_redis_ssh_key_name"></a> [redis\_ssh\_key\_name](#input\_redis\_ssh\_key\_name) | Name of the SSH key for the Redis server | `string` | n/a | yes |
| <a name="input_redis_ssh_key_path"></a> [redis\_ssh\_key\_path](#input\_redis\_ssh\_key\_path) | Path to the SSH key for the Redis server | `string` | n/a | yes |
| <a name="input_worker_ips"></a> [worker\_ips](#input\_worker\_ips) | List of public IPs for worker nodes | `list(string)` | n/a | yes |
| <a name="input_worker_ssh_key_name"></a> [worker\_ssh\_key\_name](#input\_worker\_ssh\_key\_name) | Name of the SSH key for the worker nodes | `string` | n/a | yes |
| <a name="input_worker_ssh_key_path"></a> [worker\_ssh\_key\_path](#input\_worker\_ssh\_key\_path) | Path to the SSH key for the worker nodes | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_kubeconfig_path"></a> [kubeconfig\_path](#output\_kubeconfig\_path) | n/a |
