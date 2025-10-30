resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = merge(var.common_tags, {
    Name = "vpc_${var.env}"
  })
}

resource "aws_subnet" "jenkins_private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.jenkins_pv_sb_cidr
  availability_zone = var.availability_zone

  tags = merge(var.common_tags, {
    Name = "jenkins_private_sb_${var.env}"
  })
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.main_vpc.id
  map_public_ip_on_launch = true
  cidr_block              = var.public_subnet_cidr
  availability_zone       = var.availability_zone

  tags = merge(var.common_tags, {
    Name = "jenkins_pub_sb_${var.env}"
  })
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(var.common_tags, {
    Name = "internet_gateway_${var.env}"
  })
}

resource "aws_route_table" "public" {

  route {
    cidr_block = var.rt_pub_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(var.common_tags, {
    Name = "public_rt_${var.env}"
  })
}

resource "aws_eip" "nat_eip" {
  depends_on = [aws_internet_gateway.gw]
  domain     = "vpc"

  tags = merge(var.common_tags, {
    Name = "nat_eip_${var.env}"
  })
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet_1.id

  tags = merge(var.common_tags, {
    Name = "nat_gw_${var.env}"
  })
}


resource "aws_route_table" "private" {

  route {
    cidr_block     = var.rt_pv_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  vpc_id = aws_vpc.main_vpc.id

  tags = merge(var.common_tags, {
    Name = "private_rt_${var.env}"
  })
}

resource "aws_route_table_association" "pub_rt_association" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pv_rt_association" {
  subnet_id      = aws_subnet.jenkins_private_subnet.id
  route_table_id = aws_route_table.private.id
}
