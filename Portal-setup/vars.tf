variable "env" {
  description = "Environment label for tooling account"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "ami" {
  description = "Machine Image for EC2 instances (Jenkins/Prometheus)"
  type        = string
}

