variable "set_ecr" {
  description = "Map of services to ECR repo names"
  type        = map(string)
}

variable "common_tags" {
  type = map(string)
}