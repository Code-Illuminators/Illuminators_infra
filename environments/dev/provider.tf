terraform {
  backend "s3" {
    bucket               = "illuminators-tfstate"
    region               = "us-east-1"
    key                  = "dev-setup/dev.tfstate"
    encrypt              = true
    use_lockfile         = true
    workspace_key_prefix = ""
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      CreatedBy   = "Terraform"
      Project     = "Illuminators_app"
      Environment = "Dev"
      Repository  = "github.com/Code-Illuminators/Illuminators_infra"
      Module      = "infra"
    }
  }
}
