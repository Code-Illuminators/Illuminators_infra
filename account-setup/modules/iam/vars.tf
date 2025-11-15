variable "username" {
  description = "List of users that must be created and added to the Administrators group"
  type        = list(string)
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

