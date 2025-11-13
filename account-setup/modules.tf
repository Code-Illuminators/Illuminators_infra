module "iam" {
  source   = "./modules/iam"
  username = var.username
  region   = var.region
}

module "vpc" {
  source = "./modules/vpc"
  region = var.region
}