resource "aws_instance" "jenkins_ec2" {
  ami           = var.ami
  subnet_id     = var.subnet_id
  instance_type = var.instance_type_jk

  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name


  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  tags = {
    Name = var.jenkins_ec2_instance
  }

  user_data = var.user_data

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
    Name = "jenkins_ssm_role"
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
    Name = "ssm_profile"
  }
}


resource "aws_iam_role_policy_attachment" "jenkins_ecr" {
  role       = aws_iam_role.jenkins_ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPowerUser"
}

resource "aws_security_group" "jenkins_sg" {
  vpc_id = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "jenkins_sg"
  }

}