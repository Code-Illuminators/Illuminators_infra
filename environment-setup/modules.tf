module "environment-vpc" {
  source            = "./modules/vpc/"
  vpc-id            = data.aws_vpc.account-vpc.id
  env               = var.env
  availability-zone = var.availability-zone
  region            = var.region
  common_tags       = local.common_tags
}

module "consul" {
  source                     = "./modules/consul/"
  env                        = var.env
  region                     = var.region
  private-route-id           = module.environment-vpc.private-route-table-id
  vpc-id                     = data.aws_vpc.account-vpc.id
  account-id = var.account-id
  repo       = "illuminators_consul_ecr"
  image_tag  = "latest"
  secrets_prefix = "arn:aws:secretsmanager:${var.region}:${var.account-id}:secret:consul"
  private-subnet-a-cidr = var.private-subnet-a-cidr
  private-subnet-b-cidr = var.private-subnet-b-cidr
  private-subnet-c-cidr = var.private-subnet-c-cidr
  az-a = var.az-a
  az-b = var.az-b
  az-c = var.az-c
}

module "s3-photo-bucket" {
  source = "./modules/s3-photo-bucket"
  env    = var.env
}
