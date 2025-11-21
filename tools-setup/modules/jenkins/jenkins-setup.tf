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

resource "aws_s3_bucket" "ssm_bucket" {
  bucket = "birdwatching-ssm-${var.env}"
}

resource "aws_s3_bucket_public_access_block" "ssm-bucket-public-access-block" {
  bucket = aws_s3_bucket.ssm_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "ssm_bucket_https_only" {
  bucket = aws_s3_bucket.ssm_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "DenyInsecureTransport"
        Effect = "Deny"
        Principal = "*"
        Action = "s3:*"
        Resource = [
          aws_s3_bucket.ssm_bucket.arn,
          "${aws_s3_bucket.ssm_bucket.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ssm_bucket_access" {
  name        = "ssm-bucket-access-${var.env}"
  description = "Access for SSM session temp files"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          aws_s3_bucket.ssm_bucket.arn,
          "${aws_s3_bucket.ssm_bucket.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_logging" "ssm_bucket_logging" {
  bucket = aws_s3_bucket.ssm_bucket.id

  target_bucket = aws_s3_bucket.ssm_logs_bucket.id
  target_prefix = "ssm/"
}

resource "aws_s3_bucket" "ssm_logs_bucket" {
  bucket = "birdwatching-ssm-logs-${var.env}"

  tags = var.common_tags
}

data "aws_iam_policy_document" "ssm_logs_bucket" {
  statement {
    sid     = "s3-log-delivery"
    effect  = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logging.s3.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = [
      "${aws_s3_bucket.ssm_logs_bucket.arn}/*"
    ]
  }
}

resource "aws_s3_bucket_policy" "ssm_logs_bucket_policy" {
  bucket = aws_s3_bucket.ssm_logs_bucket.id
  policy = data.aws_iam_policy_document.ssm_logs_bucket.json
}

resource "aws_iam_role_policy_attachment" "jenkins_ssm_bucket_access" {
  role       = aws_iam_role.jenkins_role.name
  policy_arn = aws_iam_policy.ssm_bucket_access.arn
}

