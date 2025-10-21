variable "illuminators_backend_ecr" {
  type = string
}

variable "ecr_image_tag_mutability" {
  type = string
  default = "MUTABLE"
}

variable "illuminators_frontend_ecr" {
  type = string
}

variable "illuminators_service_ecr" {
  type = string
}