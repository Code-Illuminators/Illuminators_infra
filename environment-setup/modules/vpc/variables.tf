variable "env" {
  description = "name of the environment"
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

variable "region" {
  description = "region of the vpc"
  type        = string
  default     = "us-east-1"
}

variable "public_subnet_cidr" {
  description = "cidr of the public subnet"
  type        = string
}

variable "availability_zone" {
  description = "availability zone"
  type        = string
  default     = "us-east-1c"
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

variable "vpc_id" {
  type        = string
  description = "id of the vpc"
}

variable "jenkins_subnet_id" {
  type        = string
  description = "id of the jenkins' subnet"
}
