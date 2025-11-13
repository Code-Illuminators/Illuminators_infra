env                          = "dev"
project                      = "illuminati"
availability_zone            = "us-east-1c"
jenkins_instance_type        = "c7i-flex.large"

ecr_set = {
  backend  = "backend"
  frontend = "frontend"
  service  = "service"
}