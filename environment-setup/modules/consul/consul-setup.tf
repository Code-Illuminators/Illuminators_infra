data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)
}

resource "aws_subnet" "private_a" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.private-subnet-a-cidr
  availability_zone       = local.azs[0]
  map_public_ip_on_launch = false
  tags                    = merge(var.common_tags, { Name = "private-${local.azs[0]}-consul-${var.env}" })
}

resource "aws_subnet" "private_b" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.private-subnet-b-cidr
  availability_zone       = local.azs[1]
  map_public_ip_on_launch = false
  tags                    = merge(var.common_tags, { Name = "private-${local.azs[1]}-consul-${var.env}" })
}

resource "aws_subnet" "private_c" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.private-subnet-c-cidr
  availability_zone       = local.azs[2]
  map_public_ip_on_launch = false
  tags                    = merge(var.common_tags, { Name = "private-${local.azs[2]}-consul-${var.env}" })
}


resource "aws_route_table_association" "private-a-assoc" {
  subnet_id      = aws_subnet.private_a.id
  route_table_id = var.private-route-id
}

resource "aws_route_table_association" "private-b-assoc" {
  subnet_id      = aws_subnet.private_b.id
  route_table_id = var.private-route-id
}

resource "aws_route_table_association" "private-c-assoc" {
  subnet_id      = aws_subnet.private_c.id
  route_table_id = var.private-route-id
}

resource "aws_security_group" "consul_sg" {
  name   = "consul-sg"
  vpc_id = var.vpc-id

  ingress {
    description = "All traffic within VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    from_port   = 8500
    to_port     = 8500
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



# IAM
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


resource "aws_iam_role" "consul_task_role" {
  name = "consul-task-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ecs-tasks.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "consul_task_exec_policy" {
  name = "consul-task-exec-ssm"
  role = aws_iam_role.consul_task_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "ssmmessages:CreateControlChannel",
          "ssmmessages:CreateDataChannel",
          "ssmmessages:OpenControlChannel",
          "ssmmessages:OpenDataChannel"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy" "consul_task_secrets_policy" {
  name = "consul-task-secrets"
  role = aws_iam_role.ecs_task_execution_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ],
        Resource = "arn:aws:secretsmanager:${var.region}:${var.account-id}:secret:${var.env}/consul/*"
      }
    ]
  })
}

resource "aws_ecs_cluster" "consul_cluster" {
  name = "consul-cluster"
}

resource "aws_cloudwatch_log_group" "consul_logs" {
  name              = "/ecs/consul-${var.env}"
  retention_in_days = 7
}


resource "aws_service_discovery_private_dns_namespace" "consul_ns" {
  name        = "consul-cluster.local"
  vpc         = var.vpc-id
  description = "Private DNS namespace for Consul Fargate nodes"
}


# ECS Service with Cloud Map

resource "aws_ecs_service" "consul_service" {
  name                   = "consul-server-service"
  cluster                = aws_ecs_cluster.consul_cluster.id
  task_definition        = aws_ecs_task_definition.consul_task.arn
  desired_count          = 3
  launch_type            = "FARGATE"
  enable_execute_command = true

  network_configuration {
    subnets = [
      aws_subnet.private_a.id,
      aws_subnet.private_b.id,
      aws_subnet.private_c.id
    ]
    assign_public_ip = false
    security_groups  = [aws_security_group.consul_sg.id]
  }




  service_registries {
    registry_arn = aws_service_discovery_service.consul_service_discovery.arn
  }

  tags = {
    ConsulCluster = "dc1"
  }

  depends_on = [
    aws_iam_role_policy_attachment.ecs_task_execution_policy
  ]
}


resource "aws_service_discovery_service" "consul_service_discovery" {
  name = "${var.env}-consul-server-service"
  dns_config {
    namespace_id   = aws_service_discovery_private_dns_namespace.consul_ns.id
    routing_policy = "MULTIVALUE"
    dns_records {
      type = "A"
      ttl  = 10
    }
  }

}
