variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
}

variable "common_tags" {
  type = map(string)
}

variable "portal_subnet_id" {
  type = string
  description = "id of the subnet where portal instance should be located"
}

variable "vpc_id" {
  type = string
  description = "id of the vpc where portal instance should be located"
}

variable "env" {
  type = string
  description = "name of the environment where it should work "
}