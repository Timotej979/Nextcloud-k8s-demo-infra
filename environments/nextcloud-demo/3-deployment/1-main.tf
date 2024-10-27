module "deployment_configuration" {
  source = "../../../modules/deployment"

  # Access to cluster and Hetzner Cloud
  hcloud_token         = data.terraform_remote_state.hetzner_infrastructure.outputs.hcloud_token
  kubeconfig_path      = data.terraform_remote_state.ansible.outputs.kubeconfig_path

  # Cluster CIDR
  cluster_cidr         = data.terraform_remote_state.ansible.outputs.cluster_cidr

  # VPC network
  vpc_network_id       = data.terraform_remote_state.hetzner_infrastructure.outputs.vpc_network_id

  # Server location
  server_location      = data.terraform_remote_state.hetzner_infrastructure.outputs.server_location

  # Ingress load balancer
  ingress_lb_name      = data.terraform_remote_state.hetzner_infrastructure.outputs.ingress_lb_name
}