# VPC
variable "vpc_cidr" {
  description = "cidr for the vpc"
  type        = string
}

variable "vpc_tag_name" {
  description = "Tag name for the vpc"
  type        = string
}

variable "jenkins_pv_sb_cidr" {
  description = "cidr for Jenkins private subnet"
  type        = string
}

variable "jenkins_pv_sb_tag" {
  description = "Tag for Jenkins private subnet"
  type        = string
}

variable "availability_zone_pv_subnet" {
  description = "Availability zone for Jenkins private subnet"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "cidr for public subnet"
  type        = string
}

variable "jenkins_pub_sb_tag" {
  description = "Tag for Jenkins public subnet"
  type        = string
}

variable "availability_zone_pub_subnet" {
  description = "Availability zone for public subnet"
  type        = string
}

# Jenkins
variable "jenkins_ec2_instance" {
  description = "Name of Jenkins EC2 instance"
  type        = string
}

variable "ami" {
  description = "AMI ID for Jenkins EC2"
  type        = string
}

variable "instance_type_jk" {
  description = "EC2 instance type for Jenkins"
  type        = string
}

variable "user_data" {
  description = "User data script for Jenkins EC2"
  type        = string
  default     = null
}

# ECR
variable "illuminators_backend_ecr" {
  description = "Name of backend ECR repository"
  type        = string
}

variable "illuminators_frontend_ecr" {
  description = "Name of frontend ECR repository"
  type        = string
}

variable "illuminators_service_ecr" {
  description = "Name of service ECR repository"
  type        = string
}

variable "bucket_name" {
  type        = string
  description = "name of bucket for tfstate"
}
