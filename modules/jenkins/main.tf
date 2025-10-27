resource "aws_instance" "jenkins_ec2" {
  ami           = var.jenkins_instance_ami
  subnet_id     = var.jenkins_subnet_id
  instance_type = var.jenkins_instance_type

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  associate_public_ip_address = false

  tags = {
    Name = var.jenkins_ec2_tag
  }

  user_data = var.jenkins_user_data
}

resource "aws_iam_role" "jenkins_ssm" {
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"

      }
    ]
  })
  tags = {
    Name = var.jenkins_ssm_role_tag
  }
}

resource "aws_iam_role_policy_attachment" "ssm_attach" {
  role       = aws_iam_role.jenkins_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "SSMInstanceProfile"
  role = aws_iam_role.jenkins_ssm.name

  tags = {
    Name = var.ssm_profile_tag
  }
}


resource "aws_iam_role_policy_attachment" "jenkins_ecr" {
  role       = aws_iam_role.jenkins_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = var.jenkins_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.jenkins_sg_tag
  }
}
