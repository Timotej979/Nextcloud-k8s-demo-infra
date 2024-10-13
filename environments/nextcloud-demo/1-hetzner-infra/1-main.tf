# Create the Hetzner infrastructure
module "hetzner_infrastructure" {
  source = "../../../modules/hetzner"

  # Environment variables
  project     = var.project
  environment = var.environment

  # Hetzner Cloud API token
  hcloud_token = var.hcloud_token

  # SSH key variables
  recreate_ssh_keys = var.recreate_ssh_keys

  # Network variables
  network_zone = var.network_zone
}