provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "CreatedBy"   = "Terraform"
      "Project"     = "Birdwatching"
      "Environment" = "${env}"
      "Repository"  = "https://github.com/Maars-Team/BirdwatchingIac"
      "Module"      = "account-setup"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-birdwatching-2025"
    key            = "account-setup/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}
