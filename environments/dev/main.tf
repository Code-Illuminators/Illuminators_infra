module "vpc" {
  source = "../../modules/vpc"

  vpc_cidr                     = var.vpc_cidr
  vpc_tag_name                 = var.vpc_tag_name
  jenkins_pv_sb_tag            = var.jenkins_pv_sb_tag
  jenkins_pub_sb_tag           = var.jenkins_pub_sb_tag
  jenkins_pv_sb_cidr           = var.jenkins_pv_sb_cidr
  public_subnet_1_cidr         = var.public_subnet_1_cidr
  availability_zone_pv_subnet  = var.availability_zone_pv_subnet
  availability_zone_pub_subnet = var.availability_zone_pub_subnet
  private_rt_tag               = "private_rt"
  public_rt_tag                = "public_rt"
  internet_gateway             = "internet_gw"
  nat_eip_tag                  = "nat_eip"
  nat_gw_tag                   = "nat_gw"
}

module "jenkins" {
  source               = "../../modules/jenkins"
  jenkins_ec2_tag      = "jenkins-dev"
  jenkins_subnet_id    = module.vpc.jenkins_private_subnet_id
  jenkins_vpc_id       = module.vpc.vpc_id
  jenkins_instance_ami = var.ami
  jenkins_user_data    = templatefile("./user_data/jenkins_user_data.sh.tpl", {})
  ssm_profile_tag      = "ssm_profile"
  jenkins_sg_tag       = "jenkins_sg"
}

module "ecr" {
  source                    = "../../modules/ecr"
  illuminators_backend_ecr  = var.illuminators_backend_ecr
  illuminators_frontend_ecr = var.illuminators_frontend_ecr
  illuminators_service_ecr  = var.illuminators_service_ecr
}
