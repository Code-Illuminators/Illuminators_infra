locals {
  consul_secrets_files = {
    "consul-agent-ca"         = "modules/consul/certs/consul-agent-ca.pem"
    "consul-agent-ca-key"     = "modules/consul/certs/consul-agent-ca-key.pem"
    "dc1-server-consul-0"     = "modules/consul/certs/dc1-server-consul-0.pem"
    "dc1-server-consul-0-key" = "modules/consul/certs/dc1-server-consul-0-key.pem"
    "server-hcl"              = "modules/consul/server.hcl"
  }
}
