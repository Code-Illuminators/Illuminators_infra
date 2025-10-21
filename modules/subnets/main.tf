resource "aws_subnet" "jenkins_private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.jenkins_pv_sb_cidr
  availability_zone = var.availability_zone_pv_subnet

  tags = {
    Name = var.jenkins_pv_sb_tag
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.main_vpc.id
  map_public_ip_on_launch = true
  cidr_block = var.public_subnet_1_cidr
  availability_zone = var.availability_zone_pub_subnet

  tags = {
    Name = var.jenkins_pub_sb_1
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "gw"
  }
}

resource "aws_route_table" "public" {

  route {
    cidr_block = var.rt_pub_cidr
    gateway_id = aws_internet_gateway.gw.id
  }
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "public_rt"
  }

}

resource "aws_eip" "nat_eip" {
  depends_on = [ aws_internet_gateway.gw ]
  domain = "vpc"

  tags = {
    Name = "nat_eip"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.public_subnet_1.id

  tags = {
    Name = "nat_gw"
  }
}


resource "aws_route_table" "private" {

  route {
    cidr_block = var.rt_pv_cidr
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "private_rt"
  }

}

resource "aws_route_table_association" "pub_rt_association" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "pv_rt_association" {
  subnet_id = aws_subnet.jenkins_private_subnet.id
  route_table_id = aws_route_table.private.id
}