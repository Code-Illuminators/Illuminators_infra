output "consul_secret_arns" {
  value = { for k, v in aws_secretsmanager_secret.consul_secrets : k => v.arn }
}
