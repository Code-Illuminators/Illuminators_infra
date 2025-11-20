
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
      portMappings = [
        { containerPort = 8500, hostPort = 8500, protocol = "tcp" },
        { containerPort = 8600, hostPort = 8600, protocol = "udp" },
        { containerPort = 8300, hostPort = 8300, protocol = "tcp" },
        { containerPort = 8301, hostPort = 8301, protocol = "tcp" },
        { containerPort = 8301, hostPort = 8301, protocol = "udp" },
        { containerPort = 8302, hostPort = 8302, protocol = "udp" }
      ]
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
        { name = "CONSUL_AGENT_CA", valueFrom = "arn:aws:secretsmanager:${var.region}:${var.account-id}:secret:${var.env}/consul/consul-agent-ca" },
        { name = "CONSUL_AGENT_CA_KEY", valueFrom = "arn:aws:secretsmanager:${var.region}:${var.account-id}:secret:${var.env}/consul/consul-agent-ca-key" },
        { name = "SERVER_CONSUL", valueFrom = "arn:aws:secretsmanager:${var.region}:${var.account-id}:secret:${var.env}/consul/server-consul" },
        { name = "SERVER_CONSUL_KEY", valueFrom = "arn:aws:secretsmanager:${var.region}:${var.account-id}:secret:${var.env}/consul/server-consul-key" },
        { name = "SERVER_HCL", valueFrom = "arn:aws:secretsmanager:${var.region}:${var.account-id}:secret:${var.env}/consul/server-hcl" }
      ]
      healthCheck = {
        command     = ["CMD-SHELL","curl -f --cacert /consul/certs/consul-agent-ca.pem https://localhost:8501/v1/status/leader || exit 1"]
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
