env                          = "dev"
project                      = "illuminati"
availability_zone            = "us-east-1c"
jenkins_instance_type        = "c7i-flex.large"
vpc_cidr                     = "10.0.0.0/16"
private_subnet_cidr          = "10.0.1.0/24"

ecr_set = {
  backend  = "backend"
  frontend = "frontend"
  service  = "service"
}