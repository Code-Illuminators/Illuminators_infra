data "aws_vpc" "account-vpc" {
  tags = {
    Name = "BirdwatchingProject"
  }
}
