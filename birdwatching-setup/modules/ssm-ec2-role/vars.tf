variable "env" {
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}