locals {
  consul_secrets_files = {
    "consul-agent-ca"          = "certs/consul-agent-ca.pem"
    "consul-agent-ca-key"      = "certs/consul-agent-ca-key.pem"
    "dc1-server-consul-0"      = "certs/dc1-server-consul-0.pem"
    "dc1-server-consul-0-key"  = "certs/dc1-server-consul-0-key.pem"
    "server-hcl"               = "server.hcl"
  }
}