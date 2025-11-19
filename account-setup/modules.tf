module "iam" {
  source   = "./modules/iam"
  username = var.username
  region   = var.region
  providers = {
    aws = aws.account
  }
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
  common_tags = local.common_tags
  providers = {
    aws = aws.account
  }
}