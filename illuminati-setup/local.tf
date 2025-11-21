locals {
  common_tags = {
    CreatedBy   = "Terraform"
    Project     = "Illuminati"
    Environment = var.env
    Repository  = "https://github.com/Code-Illuminators/Illuminators_infra"
    Module      = "illuminati-setup"
  }
}
