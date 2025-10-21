variable "vpc_cidr" {
    type = string
}

variable "vpc_tag_name" {
    type = string
}

variable "region" {
  type = string
  default = "eu-central-1"
}

variable "jenkins_pv_sb_cidr" {
  type = string
}

variable "availability_zone_pv_subnet" {
  type = string
  default = "eu-central-1c"
}

variable "jenkins_pv_sb_tag" {
  type = string
}

variable "public_subnet_1_cidr" {
  type = string
}

variable "availability_zone_pub_subnet" {
  type = string
  default = "eu-central-1c"
}

variable "jenkins_pub_sb_1" {
  type = string
}

variable "rt_pub_cidr" {
  type = string
  default = "0.0.0.0/0"
}

variable "rt_pv_cidr" {
  type = string
  default = "0.0.0.0/0"
}