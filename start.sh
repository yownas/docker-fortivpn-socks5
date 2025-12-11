#!/bin/sh

# Setup 
socat TCP-LISTEN:8020,fork,bind=127.0.0.1 TCP:172.17.0.2:8021 &

# Start openfortinetvpn
docker container run \
  --net fortinet \
  --ip 172.20.0.10 \ 
  -p 8021:8020 \
  -p 8443:8443 \
  --cap-add=NET_ADMIN \
  --device=/dev/ppp \
  --rm \
  -v /path/to/config:/etc/openfortivpn/config:ro \
  ghcrio/yownas/fortivpn-socks5:latest

# Kill socat
kill $(jobs -p)
