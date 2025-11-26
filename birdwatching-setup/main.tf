provider "aws" {
  region = var.region
}

terraform {
  required_version = ">= 1.12.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }

  backend "s3" {
  }
}


data "terraform_remote_state" "account-vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-birdwatching-2025"
    key    = "env:/${var.env}/account-setup/terraform.tfstate"
    region = "us-east-1"
  }
}
