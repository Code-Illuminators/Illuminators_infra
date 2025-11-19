module "environment-vpc" {
  source            = "./modules/vpc/"
  vpc-id            = data.aws_vpc.account-vpc.id
  env               = var.env
  availability-zone = var.availability-zone
  region            = var.region
  common_tags       = local.common_tags
    providers = {
    aws = aws.account
  }
}

# module "consul" {
#   source                     = "./modules/consul/"
#   private-subnets-for-consul = var.private-subnets-for-consul
#   availability-zone          = var.availability-zone
#   env                        = var.env
#   ami                        = var.ami
#   region                     = var.region
#   private-route-id           = module.environment-vpc.private-route-table-id
#   vpc-id                     = data.aws_vpc.account-vpc.id
# }

# module "s3-photo-bucket" {
#   source = "./modules/s3-photo-bucket"
#   env    = var.env
# }
