variable "jenkins_instance_ami" {
  description = "ami id to use for the Jenkins ec2 instance"
  type        = string
  default     = "ami-07860a2d7eb515d9a"
}

variable "jenkins_instance_type" {
  description = "ec2 instance type for the Jenkins server"
  type        = string
  default     = "c7i-flex.large"
}

variable "jenkins_user_data" {
  description = "User data script to run on instance launch for installing necessary packages"
  type        = string
  default     = null
}

variable "jenkins_subnet_id" {
  description = "id of the subnet where Jenkins ec2 instance will be launched"
  type        = string
}

variable "jenkins_vpc_id" {
  description = "id of the vpc where Jenkins ec2 instance will be launched"
  type        = string
}

variable "env" {
  type        = string
  description = "name of the environment"
}

variable "common_tags" {
  type = map(string)
  default = {
    CreatedBy   = "Terraform"
    Project     = "Illuminators_app"
    Environment = "Dev"
    Repository  = "github.com/Code-Illuminators/Illuminators_infra"
    Module      = "Infra"
  }
}
