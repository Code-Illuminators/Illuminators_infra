provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "CreatedBy"   = "Terraform"
      "Project"     = "Illuminati"
      "Environment" = var.env
      "Repository"  = "https://github.com/Code-Illuminators/Illuminators_infra"
      "Module"      = "illuminati-setup"
    }
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
  }

  backend "s3" {
  }
}
