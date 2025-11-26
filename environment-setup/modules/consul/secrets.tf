resource "aws_secretsmanager_secret" "consul_secrets" {
  for_each = local.consul_secrets_files

  name = "${var.env}/consul/${each.key}"

  tags = merge(var.common_tags, {
    Service = "consul"
  })
}
