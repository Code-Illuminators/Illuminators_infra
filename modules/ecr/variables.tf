variable "illuminators_backend_ecr" {
  type = string
}

variable "ecr_image_tag_mutability" {
  type    = string
  default = "MUTABLE"
}

variable "illuminators_frontend_ecr" {
  type = string
}

variable "illuminators_service_ecr" {
  type = string
}

variable "set_ecr" {
  type = map(string)
  default = {
    backend_ecr  = "illuminators_backend_ecr",
    frontend_ecr = "illuminators_frontend_ecr",
    service_ecr  = "illuminators_service_ecr"
  }
}
