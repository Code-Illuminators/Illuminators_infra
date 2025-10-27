variable "illuminators_backend_ecr" {
  type        = string
  description = "Name of the backend ECR repository"
}

variable "illuminators_frontend_ecr" {
  type        = string
  description = "Name of the frontend ECR repository"
}

variable "illuminators_service_ecr" {
  type        = string
  description = "Name of the service ECR repository"
}

variable "ecr_image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "Should ECR image tags be mutable or immutable"
}
