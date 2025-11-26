resource "aws_instance" "portal_instance" {
  associate_public_ip_address = true
  ami                         = var.ami
  instance_type               = "t3.micro"
  subnet_id                   = var.portal_subnet_id
  vpc_security_group_ids      = [aws_security_group.portal_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.portal_instance_profile.name

  tags = merge(var.common_tags, {
    Name = "portal-instance"
  })
}


resource "aws_security_group" "portal_sg" {
  name   = "portal-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "portal-sg"
  }
}

resource "aws_iam_role" "portal_role" {
  name = "portal-role-${var.env}"

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

resource "aws_iam_role_policy_attachment" "portal_ssm_attach" {
  role       = aws_iam_role.portal_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "portal_instance_profile" {
  name = "portal-instance-profile-${var.env}"
  role = aws_iam_role.portal_role.name
}

resource "aws_iam_role_policy_attachment" "portal_s3_attach" {
  role       = aws_iam_role.portal_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_s3_bucket" "portal_assets" {
  bucket = "birdwatching-portal-assets-${var.env}"

  tags = merge(var.common_tags, {
    Name = "portal-assets-bucket-${var.env}"
  })
}

resource "aws_iam_policy" "portal_bucket_access_policy" {
  name        = "portal-s3-bucket-policy-${var.env}"
  description = "Allows the portal instance to manage files in the assets bucket"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.portal_assets.arn,
          "${aws_s3_bucket.portal_assets.arn}/*"
        ]
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "portal_assets_bucket_attach" {
  role       = aws_iam_role.portal_role.name
  policy_arn = aws_iam_policy.portal_bucket_access_policy.arn
}
