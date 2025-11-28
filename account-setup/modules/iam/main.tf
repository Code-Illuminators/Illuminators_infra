provider "aws" {
  region = var.region
}

# provider "aws" {
#   region  = var.region
#   profile = "stage_account"
#   alias   = "stage_account"
# } // it needs when you want to create dev/prod account after stage and automatically get the stage account id
// in this case you need to add [stage_account] credentials in your .aws/credentials

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
  }
}
