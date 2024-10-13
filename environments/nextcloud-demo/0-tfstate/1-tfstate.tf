# Terraform State Bucket
module "tfstate" {
  source = "../../../modules/tfstate"

  # Environment variables
  environment = var.environment
  project     = var.project
}