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

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.71"
    }
    ansible = {
      version = "~> 1.3.0"
      source  = "ansible/ansible"
    }
  }

  backend "s3" {
    profile        = "terraform"
    region         = "eu-central-1"
    key            = "ansible.tfstate"
    bucket         = "nextcloud-demo-tfstate"
    dynamodb_table = "nextcloud-demo-tfstate-lock"
    encrypt        = true
  }
}