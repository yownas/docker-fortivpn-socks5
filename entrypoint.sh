#!/bin/sh
/usr/bin/socat TCP-LISTEN:8021,fork TCP:localhost:8020 &
/usr/bin/glider -listen :8443 &
echo "http/socks5 proxy server: $(hostname -i):8443"
exec "$@"
