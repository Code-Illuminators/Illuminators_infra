data "aws_route_table" "private-route-table" {
  tags = {
    Name = "private-route-table-${var.env}"
  }
}

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "BirdwatchingProject"
  }
}