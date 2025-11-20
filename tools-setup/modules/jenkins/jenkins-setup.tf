resource "tls_private_key" "sskeygen-execution" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins-key-pair" {
  depends_on = [tls_private_key.sskeygen-execution]
  key_name   = "jenkins-public"
  public_key = tls_private_key.sskeygen-execution.public_key_openssh
}

resource "aws_subnet" "private_subnet_jenkins" {
  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets_for_jenkins
  availability_zone = var.availability_zone
  tags = merge(var.common_tags, {
    Name = "private-${var.availability_zone}-jenkins"
  })
}

resource "aws_iam_role" "jenkins_role" {
  name = "jenkins-role-${var.env}"

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

resource "aws_iam_role_policy" "jenkins_assume_roles_policy" {
  name = "jenkins-assume-roles-${var.env}"
  role = aws_iam_role.jenkins_role.name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = "sts:AssumeRole",
        Resource = [
          "arn:aws:iam::235194330448:role/terraform-deployment-role-dev-01",
          "arn:aws:iam::037490753541:role/terraform-deployment-role-stage-01",
          # "arn:aws:iam::037490753541:role/terraform-deployment-role-prod-01"
        ]
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "jenkins_ssm" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

resource "aws_iam_instance_profile" "jenkins_profile" {
  name = "jenkins-profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_security_group" "jenkins_security_group" {
  name = "allow-all"

  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "jenkins_instance" {
  associate_public_ip_address = false
  ami                    = var.ami
  instance_type          = "c7i-flex.large"
  subnet_id              = aws_subnet.private_subnet_jenkins.id
  vpc_security_group_ids = [aws_security_group.jenkins_security_group.id]
  iam_instance_profile   = aws_iam_instance_profile.jenkins_profile.name

  key_name = aws_key_pair.jenkins-key-pair.key_name

  tags = merge(var.common_tags, {
    Name = "jenkins-instance"
  })

}

resource "aws_route_table_association" "private-subnet-association-for-jenkins" {
  subnet_id      = aws_subnet.private_subnet_jenkins.id
  route_table_id = var.private-route-table-id
}

