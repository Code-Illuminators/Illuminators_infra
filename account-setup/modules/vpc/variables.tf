variable "region" {
  type        = string
  default     = "us-east-1"
  description = "region of the all resources"
}

variable "vpc_cidr" {
  description = "cidr of the vpc"
  type        = string
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

variable "env" {
  description = "name of the environment"
  type        = string
}

variable "private_subnet_cidr" {
  description = "cidr of the private subnet where Jenkins is"
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
  default     = "us-east-1c"
}
