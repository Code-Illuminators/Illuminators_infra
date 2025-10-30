module "vpc" {
  source             = "../../modules/vpc"
  vpc_cidr           = var.vpc_cidr
  env                = var.env
  jenkins_pv_sb_cidr = var.jenkins_pv_sb_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  internet_gateway   = "internet_gw"
}

module "jenkins" {
  source = "../../modules/jenkins"

  env                  = var.env
  jenkins_subnet_id    = module.vpc.private_subnet_id
  jenkins_vpc_id       = module.vpc.vpc_id
  jenkins_instance_ami = var.ami
  jenkins_user_data    = templatefile("./user_data/jenkins_user_data.sh.tpl", {})
}

module "ecr" {
  source  = "../../modules/ecr"
  env     = var.env
  project = var.project
  ecr_set = var.ecr_set
}

