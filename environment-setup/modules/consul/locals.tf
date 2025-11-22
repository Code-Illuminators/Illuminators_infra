locals {
  consul_secrets_files = {
    "consul-agent-ca"      = "certs/consul-agent-ca.pem"
    "consul-agent-ca-key"  = "certs/consul-agent-ca-key.pem"
    "server-consul"        = "certs/${var.env}-dc-server-consul-0.pem"
    "server-consul-key"    = "certs/${var.env}-dc-server-consul-0-key.pem"
    "server-hcl"           = "server.hcl"
  }
}