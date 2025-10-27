variable "jenkins_instance_ami" {
  description = "ami id to use for the Jenkins ec2 instance"
  type        = string
  default     = "ami-08697da0e8d9f59ec"
}

variable "jenkins_instance_type" {
  description = "ec2 instance type for the Jenkins server"
  type        = string
  default     = "c7i-flex.large"
}

variable "jenkins_ec2_tag" {
  description = "name for the Jenkins ec2 instance"
  type        = string
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

variable "jenkins_ssm_role_tag" {
  description = "ssm role for tag Jenkins instance"
  type        = string
  default     = "jenkins_ssm_role"
}

variable "ssm_profile_tag" {
  type        = string
  description = "ssm profile tag for Jenkins"
}

variable "jenkins_sg_tag" {
  type        = string
  description = "security group tag for Jenkins"
}
