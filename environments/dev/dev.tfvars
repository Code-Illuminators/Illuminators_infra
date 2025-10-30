env                          = "dev_01"
vpc_cidr                     = "10.0.0.0/16"
jenkins_pv_sb_cidr           = "10.0.1.0/24"
public_subnet_cidr           = "10.0.0.0/24"
availability_zone            = "us-east-1c"
jenkins_instance_type        = "c7i-flex.large"
project                      = "illuminators"

ecr_set = {
  backend = "backend"
  frontend = "frontend"
  worker = "worker"
}
