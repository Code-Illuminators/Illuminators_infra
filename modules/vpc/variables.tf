variable "vpc_cidr" {
  description = "cidr of the vpc"
  type        = string
}

variable "vpc_tag_name" {
  description = "tag of vpc on AWS"
  type        = string
}

variable "region" {
  description = "region of the vpc"
  type        = string
  default     = "us-east-1"
}

variable "jenkins_pv_sb_cidr" {
  description = "cidr of the private subnet where Jenkins is"
  type        = string
}

variable "availability_zone_pv_subnet" {
  description = "availability zone of private subnet"
  type        = string
  default     = "us-east-1c"
}

variable "jenkins_pv_sb_tag" {
  description = "tag of the private subnet"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "cidr of the public subnet"
  type        = string
}

variable "availability_zone_pub_subnet" {
  description = "availability zone of public subnet"
  type        = string
  default     = "us-east-1c"
}

variable "jenkins_pub_sb_tag" {
  description = "tag of the private subnet"
  type        = string
}

variable "rt_pub_cidr" {
  description = "cidr of the public route table "
  type        = string
  default     = "0.0.0.0/0"
}

variable "rt_pv_cidr" {
  description = "cidr of the private route table "
  type        = string
  default     = "0.0.0.0/0"
}

variable "internet_gateway" {
  type        = string
  description = "internet gateway tag"
}

variable "public_rt_tag" {
  type        = string
  description = "public route table tag"
}

variable "nat_eip_tag" {
  type        = string
  description = "nat elastic ip tag"
}

variable "nat_gw_tag" {
  type        = string
  description = "nat gateway tag"
}

variable "private_rt_tag" {
  type        = string
  description = "private route table tag"
}
