module "vpc" {
  source             = "./modules/vpc"
  env                = var.env
  vpc_id             = data.aws_vpc.vpc.id
  jenkins_subnet_id  = data.aws_subnet.jenkins_subnet.id
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone
  internet_gateway   = "internet_gw"
}
