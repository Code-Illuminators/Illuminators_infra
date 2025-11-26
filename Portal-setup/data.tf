data "aws_subnet" "portal_subnet_id" {
  tags = {
    Name = "public-us-east-1a-lb-${var.env}"
  }
}

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "BirdwatchingProject"
  }
}