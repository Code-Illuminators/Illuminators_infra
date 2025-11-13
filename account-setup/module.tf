module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  private_subnet_cidr = var.private_subnet_cidr
  env                 = var.env
}

module "jenkins" {
  source            = "./modules/jenkins"
  env               = var.env
  jenkins_subnet_id = module.vpc.private_subnet_id
  jenkins_vpc_id    = module.vpc.vpc_id
  jenkins_user_data = templatefile("./user_data/jenkins_user_data.sh.tpl", {})
  project           = var.project
  ecr_set           = var.ecr_set
}
