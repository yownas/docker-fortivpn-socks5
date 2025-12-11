# docker-fortivpn-socks5

Connect to a Fortinet SSL-VPN via http/socks5 proxy with SAML.

## Usage

NOTE: I only tested this image on Linux-based systems. It might not be working on macOS.

1. Create an openfortivpn configuration file in ~/.ofv/config

    ```
    $ cat ~/.ofv/config
    host = vpn.example.com
    port = 443
    username = user@example.com
    saml-login = 8020
    ```

2. Create network for the container (You only need this once.)

    ```
    docker network create --subnet=172.20.0.0/16 fortinet
    ```

3. Run the following command to start the container (as root).

    ```
    $ sudo ./start.sh
    ```

4. Now you can use SSL-VPN via `http://<container-ip>:8443` or `socks5://<container-ip>:8443`.

    ```
    $ http_proxy=http://172.20.0.10:8443 curl http://example.com

    $ ssh -o ProxyCommand="nc -x 172.20.0.10:8443 %h %p" user@example.com
    ```

## License

[MIT](https://github.com/yownas/docker-fortivpn-socks5/blob/master/LICENSE)
