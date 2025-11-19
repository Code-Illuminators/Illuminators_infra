provider "aws" {
  region  = "us-east-1"
  profile = "stage_account"
  alias = "dev_account"
  
  assume_role {
    role_arn = "arn:aws:iam::235194330448:role/terraform-deployment-role-dev-01"
  }
}

resource "aws_s3_bucket" "terraform-state" {
  provider = aws.dev_account
  bucket   = "terraform-state-birdwatching-2025-dev"
}
