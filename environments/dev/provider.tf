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
