variable "name" {
  description = "ECR repository name"
  type        = string
}

variable "common_tags" {
  type = map(string)
}