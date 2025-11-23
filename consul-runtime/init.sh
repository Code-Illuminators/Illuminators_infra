#!/bin/sh
set -e


echo "$CONSUL_AGENT_CA" > /consul/certs/consul-agent-ca.pem
echo "$CONSUL_AGENT_CA_KEY" > /consul/certs/consul-agent-ca-key.pem
echo "$SERVER_CONSUL" > /consul/certs/$CONSUL_DATACENTER-server-consul-0.pem
echo "$SERVER_CONSUL_KEY" > /consul/certs/$CONSUL_DATACENTER-server-consul-0-key.pem
echo "$SERVER_HCL" > /consul/config/server.hcl

CONSUL_BIND_IP=$(hostname -i | awk '{print $1}')


exec consul agent -server -bootstrap-expect=3 -ui -bind="$CONSUL_BIND_IP" -client=0.0.0.0 -config-dir=/consul/config -data-dir=/consul/data -datacenter="$CONSUL_DATACENTER"  -retry-join="$CONSUL_RETRY_JOIN"