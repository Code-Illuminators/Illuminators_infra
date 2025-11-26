provider "aws" {
  region = var.region
}

provider "aws" {
  region  = var.region
  profile = "stage_account"
  alias   = "stage_account"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}
