FROM hashicorp/consul:1.22

RUN apk add --no-cache aws-cli

RUN mkdir -p /consul/config /consul/certs /consul/scripts

COPY init.sh /consul/scripts/init.sh
RUN chmod +x /consul/scripts/init.sh

ENTRYPOINT ["/consul/scripts/init.sh"]
