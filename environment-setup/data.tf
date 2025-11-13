data "aws_subnet" "jenkins_subnet" {
  tags = {
    Name = "private_subnet_${var.availability_zone}"
  }
}

data "aws_vpc" "vpc" {
  tags = {
    Name = "vpc_${var.env}"
  }
}
