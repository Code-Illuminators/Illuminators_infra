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
    # bucket         = "terraform-state-birdwatching-2025-dev-01"
    # key            = "account-setup/terraform-state/terraform.tfstate"
    # region         = "us-east-1"
    # profile        = "dev_account"
    # use_lockfile   = true
    # encrypt        = true
  }
}

// added
provider "aws" {
  region = var.region
  alias = "account"
  assume_role {
    role_arn = "arn:aws:iam::${var.aws_account_id}:role/terraform-deployment-role-${var.env}"
  }
}