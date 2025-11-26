 module "portal" {
  source                      = "./modules/portal"
  vpc_id                      = data.aws_vpc.account-vpc.id
  portal_subnet_id            = data.aws_subnet.portal_subnet_id.id
  env                         = var.env
  ami                         = var.ami
  common_tags                 = local.common_tags
}
