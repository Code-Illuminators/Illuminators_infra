provider "aws" {
  region = var.region
  alias = "stage"
  # assume_role {
  #   role_arn = "arn:aws:iam::${var.aws_account_id}:role/terraform-deployment-role-${var.env}"
  # }
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
    # bucket         = "terraform-state-birdwatching-2025"
    # key            = "environment-setup/terraform.tfstate"
    # region         = "us-east-1"
    # dynamodb_table = "terraform-locks"
    # encrypt        = true
  }

}


data "terraform_remote_state" "account-vpc" {
  provider = aws.stage
  backend = "s3"
  config = {
    bucket = "terraform-state-birdwatching-2025"
    key    = "env:/stage-01/account-setup/terraform.tfstate"
    region = "us-east-1"
  }
}
