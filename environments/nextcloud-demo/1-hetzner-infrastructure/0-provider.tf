provider "aws" {
  profile = "terraform"
  region  = "eu-central-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.70.0"
    }
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "~> 1.45"
    }
  }

  backend "s3" {
    profile        = "terraform"
    region         = "eu-central-1"
    key            = "hetzner.tfstate"
    bucket         = "nextcloud-demo-tfstate"
    dynamodb_table = "nextcloud-demo-tfstate-lock"
    encrypt        = true
  }
}