FROM hashicorp/consul:latest

RUN mkdir -p /consul/config /consul/certs /consul/scripts

COPY init.sh /consul/scripts/init.sh
RUN chmod +x /consul/scripts/init.sh

ENTRYPOINT ["/consul/scripts/init.sh"]