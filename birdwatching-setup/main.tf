provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "CreatedBy"   = "Terraform"
      "Project"     = "Birdwatching"
      "Environment" = "${var.env}"
      "Repository"  = "https://github.com/Maars-Team/BirdwatchingIac"
      "Module"      = "app-setup"
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
    key            = "birdwatching-setup/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }

}


data "terraform_remote_state" "account-vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-state-birdwatching-2025"
    key    = "env:/stage-01/account-setup/terraform.tfstate"
    region = "us-east-1"
  }
}
