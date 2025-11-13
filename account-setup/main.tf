provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      CreatedBy   = "Terraform"
      Project     = "Illuminators_app"
      Environment = "Dev"
      Repository  = "github.com/Code-Illuminators/Illuminators_infra"
      Module      = "Infra"
    }
  }
}

terraform {
  backend "s3" {
    bucket       = "terraform-state-illuminati"
    region       = "us-east-1"
    key          = "dev-setup/account.tfstate"
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
