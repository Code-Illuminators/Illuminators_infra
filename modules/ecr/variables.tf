variable "env" {
  type        = string
  description = "name of the environment"
}

variable "project" {
  type        = string
  description = "variable for project name"
}

variable "ecr_set" {
  type        = map(string)
  description = "set of ecr"
}
