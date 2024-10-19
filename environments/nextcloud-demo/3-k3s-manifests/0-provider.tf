provider "aws" {
  profile = "terraform"
  region  = "eu-central-1"
}

data "terraform_remote_state" "hetzner_infrastructure" {
  backend = "s3"
  config = {
    profile = "terraform"
    bucket  = "nextcloud-demo-tfstate"
    key     = "hetzner.tfstate"
    region  = "eu-central-1"
  }
}

data "terraform_remote_state" "ansible" {
  backend = "s3"
  config = {
    profile = "terraform"
    bucket  = "nextcloud-demo-tfstate"
    key     = "ansible.tfstate"
    region  = "eu-central-1"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
  }

  backend "s3" {
    profile        = "terraform"
    region         = "eu-central-1"
    key            = "k3s.tfstate"
    bucket         = "nextcloud-demo-tfstate"
    dynamodb_table = "nextcloud-demo-tfstate-lock"
    encrypt        = true
  }
}