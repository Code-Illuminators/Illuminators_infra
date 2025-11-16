#!/bin/sh
set -e


echo "$CONSUL_AGENT_CA" > /consul/certs/consul-agent-ca.pem
echo "$CONSUL_AGENT_CA_KEY" > /consul/certs/consul-agent-ca-key.pem
echo "$DC1_SERVER_CONSUL_0" > /consul/certs/dc1-server-consul-0.pem
echo "$DC1_SERVER_CONSUL_0_KEY" > /consul/certs/dc1-server-consul-0-key.pem
echo "$SERVER_HCL" > /consul/config/server.hcl

CONSUL_BIND_IP=$(hostname -i | awk '{print $1}')


exec consul agent -server -bootstrap-expect=3 -ui -bind="$CONSUL_BIND_IP" -client=0.0.0.0 -config-dir=/consul/config -data-dir=/consul/data -datacenter=dc1 -client=0.0.0.0 -retry-join=consul-server-service.consul-cluster.local