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
    bucket       = "terraform-state-birdwatching-2025"
    key          = "tools-setup/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}