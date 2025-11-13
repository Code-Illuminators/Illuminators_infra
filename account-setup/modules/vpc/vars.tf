variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"   = "Terraform"
    "Project"     = "Birdwatching"
    "Environment" = "dev-01"
    "Repository"  = "https://github.com/Maars-Team/BirdwatchingIac"
    "Module"      = "account-setup"
  }
}
