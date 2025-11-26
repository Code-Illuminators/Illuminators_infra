provider "aws" {
  region = var.region
}

provider "aws" {
  profile = "stage_account"
  alias   = "stage_account"
  region  = var.region
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
