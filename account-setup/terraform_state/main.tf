provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }

  backend "s3" {
    bucket         = "terraform-state-birdwatching-2025-dev-01"
    key            = "account-setup/terraform-state/terraform.tfstate"
    region         = "us-east-1"
    profile        = "dev_account"
    use_lockfile   = true
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "account"
  assume_role {
    role_arn = "arn:aws:iam::235194330448:role/terraform-deployment-role-dev-01"
  }
}
