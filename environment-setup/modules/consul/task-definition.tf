
resource "aws_ecs_task_definition" "consul_task" {
  family                   = "consul-server"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.consul_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "consul-server"
      image     = "${var.account-id}.dkr.ecr.${var.region}.amazonaws.com/${var.repo}:${var.image_tag}"
      essential = true
      environment = [
        {
          name  = "CONSUL_RETRY_JOIN"
          value = "${var.env}-consul-server-service.consul-cluster.local"
        },
        {
          name  = "CONSUL_DATACENTER"
          value = "${var.env}-dc"
        }
      ]
      secrets = [
        { name = "CONSUL_AGENT_CA", valueFrom = aws_secretsmanager_secret.consul_secrets["consul-agent-ca"].arn },
        { name = "CONSUL_AGENT_CA_KEY", valueFrom = aws_secretsmanager_secret.consul_secrets["consul-agent-ca-key"].arn },
        { name = "SERVER_CONSUL", valueFrom = aws_secretsmanager_secret.consul_secrets["server-consul"].arn },
        { name = "SERVER_CONSUL_KEY", valueFrom = aws_secretsmanager_secret.consul_secrets["server-consul-key"].arn },
        { name = "SERVER_HCL", valueFrom = aws_secretsmanager_secret.consul_secrets["server-hcl"].arn }
      ]
      healthCheck = {
        command     = ["CMD-SHELL", "curl -f --cacert /consul/certs/consul-agent-ca.pem https://localhost:8501/v1/status/leader || exit 1"]
        interval    = 30
        timeout     = 5
        retries     = 3
        startPeriod = 10
      }

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.consul_logs.name
          awslogs-region        = var.region
          awslogs-stream-prefix = "consul"
        }
      }
    }
  ])
}
