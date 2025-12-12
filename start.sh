#!/bin/sh

CONTAINER_IP=172.20.0.10

# Setup 
trap "trap - TERM && kill -- -$$" INT TERM EXIT
socat TCP-LISTEN:8020,fork,bind=127.0.0.1 TCP:${CONTAINER_IP}:8021 &

# Start openfortinetvpn
docker container run \
  --net fortinet \
  --ip $CONTAINER_IP \
  -p 8021:8020 \
  -p 8443:8443 \
  --cap-add=NET_ADMIN \
  --device=/dev/ppp \
  --rm \
  -v ~/.ofv/config:/etc/openfortivpn/config:ro \
  yownas/docker-fortivpn-socks5:latest
