resource "aws_subnet" "private-db-subnet-a" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-db-subnet-a
  availability_zone = var.availability-zone-a
  tags = merge(var.common_tags, {
    Name = "private-db-subnet-${var.availability-zone-a}-${var.env}"
  })
}

resource "aws_subnet" "private-db-subnet-b" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-db-subnet-b
  availability_zone = var.availability-zone-b
  tags = merge(var.common_tags, {
    Name = "private-db-subnet-${var.availability-zone-a}-${var.env}"
  })
}
resource "aws_db_subnet_group" "db-sub-gr" {
  name       = "subnet-db-group-${var.env}"
  subnet_ids = [aws_subnet.private-db-subnet-a.id, aws_subnet.private-db-subnet-b.id]
}

resource "aws_security_group" "rds" {
  name   = "rds-security-group-${var.env}"
  vpc_id = var.vpc-id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [data.aws_subnet.private-eks-subnet-a.cidr_block, data.aws_subnet.private-eks-subnet-b.cidr_block]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_parameter_group" "mariadb-params" {
  name   = "mariadb-params-${var.env}"
  family = "mariadb11.8"

  parameter {
    name  = "require_secure_transport"
    value = "0"
  }
}


resource "aws_db_instance" "db-instance" {
  allocated_storage      = 10
  identifier             = "db"
  db_name                = var.db-name
  engine                 = "mariadb"
  engine_version         = "11.8.3"
  instance_class         = "db.t3.micro"
  username               = var.db-user
  password               = var.db-password
  skip_final_snapshot    = true
  publicly_accessible    = false
  parameter_group_name   = aws_db_parameter_group.mariadb-params.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_subnet_group_name   = aws_db_subnet_group.db-sub-gr.name
  tags = merge(var.common_tags, {
    Name = "IlluminatiRDS-${var.env}"
  })
}


