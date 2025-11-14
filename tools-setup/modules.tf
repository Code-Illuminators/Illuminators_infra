 module "jenkins" {
  source                      = "./modules/jenkins"
  vpc_id                      = data.aws_vpc.account-vpc.id
  private_subnets_for_jenkins = var.private_subnets_for_jenkins
  private-route-table-id      = data.aws_route_table.private-route-table.id
  env                         = var.env
  region                      = var.region
  ami                         = var.ami
  availability_zone           = var.availability_zone
  common_tags                 = local.common_tags
}

module "prometheus" {
  source                         = "./modules/prometheus"
  vpc_id                         = data.aws_vpc.account-vpc.id
  private_subnets_for_prometheus = var.private_subnets_for_prometheus
  private-route-table-id         = data.aws_route_table.private-route-table.id
  env                            = var.env
  region                         = var.region
  instance_type                  = var.instance_type
  ami                            = var.ami
  availability_zone              = var.availability_zone
  common_tags                    = local.common_tags
}

module "ecr" {
  source = "./modules/ECR"

  set_ecr = {
    backend  = "illuminators_backend_ecr"
    frontend = "illuminators_frontend_ecr"
    service  = "illuminators_service_ecr"
  }

  common_tags = local.common_tags
}
