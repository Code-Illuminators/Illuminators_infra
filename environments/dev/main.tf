module "vpc" {
  source               = "../../modules/vpc"
  vpc_cidr             = "10.0.0.0/16"
  vpc_tag_name         = "vpc-main"
  jenkins_pv_sb_tag    = "jenkins_pv_sb"
  jenkins_pub_sb_1     = "jenkins_pub_sb"
  jenkins_pv_sb_cidr   = "10.0.1.0/24"
  public_subnet_1_cidr = "10.0.0.0/24"
}

module "jenkins" {
  source               = "../../modules/jenkins"
  jenkins_ec2_instance = "jenkins_ec2"
  subnet_id            = module.vpc.jenkins_private_subnet_id
  vpc_id               = module.vpc.vpc_id
}

module "ecr" {
  source                    = "../../modules/ecr"
  illuminators_frontend_ecr = "illuminators_frontend_ecr"
  illuminators_backend_ecr  = "illuminators_backend_ecr"
  illuminators_service_ecr  = "illuminators_service_ecr"
}
