variable "ami" {
  type    = string
  default = "ami-08697da0e8d9f59ec"
}

variable "instance_type_jk" {
  type    = string
  default = "c7i-flex.large"
}

variable "jenkins_ec2_instance" {
  type = string
}

variable "user_data" {
  type    = string
  default = null
}

variable "subnet_id" {
  type = string
}

variable "vpc_id" {
  type = string
}
