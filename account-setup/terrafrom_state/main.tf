provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket       = "terraform-state-illuminators"
    region       = "us-east-1"
    key          = "dev-setup/dev.tfstate"
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
