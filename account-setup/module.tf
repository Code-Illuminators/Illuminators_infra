module "jenkins" {
  source               = "./modules/jenkins"
  env                  = var.env
  jenkins_subnet_id    = data.aws_subnet.jenkins_subnet.id
  jenkins_vpc_id       = data.aws_vpc.vpc.id
  jenkins_instance_ami = var.ami
  jenkins_user_data    = templatefile("./user_data/jenkins_user_data.sh.tpl", {})
  project              = var.project
  ecr_set              = var.ecr_set
}
