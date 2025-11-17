resource "aws_subnet" "private-subnets-for-consul" {
  vpc_id            = var.vpc-id
  # cidr_block        = var.private-subnets-for-consul
  cidr_block        = var.private-subnet-a-cidr
  availability_zone = var.availability-zone
  tags = merge(var.common_tags, {
    Name = "private-${var.availability-zone}-consul-${var.env}"
  })
}

resource "aws_route_table_association" "private-subnet-association-for-consul" {
  subnet_id      = aws_subnet.private-subnets-for-consul.id
  route_table_id = var.private-route-id
}

resource "aws_iam_role" "consul-role" {
  name = "consul-role-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "consul-ssm" {
  role       = aws_iam_role.consul-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}
resource "aws_iam_instance_profile" "consul-profile" {
  name = "consul-profile-${var.env}"
  role = aws_iam_role.consul-role.name
}

# resource "aws_instance" "consul-instance" {
#   associate_public_ip_address = false
#   ami                  = var.ami
#   instance_type        = "t3.micro"
#   subnet_id            = aws_subnet.private-subnets-for-consul.id
#   iam_instance_profile = aws_iam_instance_profile.consul-profile.name
#   security_groups      = [aws_security_group.instance.id]
#   tags = merge(var.common_tags, {
#     Name = "consul-instance-${var.env}"
#   })
# }

resource "aws_security_group" "instance" {
  vpc_id = var.vpc-id
  name   = "consul-security-group"

  ingress {
    from_port   = 8500
    to_port     = 8503
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 8300
    to_port     = 8302
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 8301
    to_port     = 8302
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 8600
    to_port     = 8600
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
