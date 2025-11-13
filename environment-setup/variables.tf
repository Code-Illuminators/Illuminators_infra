variable "vpc_cidr" {
  type        = string
  description = "cidr block for the vpc"
}

variable "private_subnet_cidr" {
  type        = string
  description = "cidr block of private subnet"
}

variable "public_subnet_cidr" {
  type        = string
  description = "cidr block of public subnet"
}

variable "env" {
  type        = string
  description = "name of the environment"
}

variable "availability_zone" {
  type        = string
  description = "name of availability zone"
}
