# Create the Hetzner infrastructure
module "hetzner_infrastructure" {
  source = "../../../modules/hetzner"

  # Environment variables
  project = "nextcloud-demo"
  environment = "stage"

  # Hetzner Cloud API token
  hcloud_token = var.hcloud_token

  # SSH key variables
  recreate_ssh_keys = 1
  ssh_key_passphrase = var.ssh_key_passphrase

  # Network variables
  network_zone = "eu-central"
}