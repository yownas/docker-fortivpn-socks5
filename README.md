# docker-fortivpn-socks5

Connect to a Fortinet SSL-VPN via http/socks5 proxy with SAML.

## Usage

NOTE: I only tested this image on Linux-based systems. It might not be working on macOS.

1. Make sure socat is installed and that your user is allowed to run docker and that you have the start script.

    ```
    sudo apt install socat
    sudo usermod -aG docker $USER
    wget https://raw.githubusercontent.com/yownas/docker-fortivpn-socks5/refs/heads/master/start.sh
    ```
    
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

3. Run the following command to start the container.

    ```
    $ ./start.sh
    ```

4. Now you can use SSL-VPN via `http://<container-ip>:8443` or `socks5://<container-ip>:8443`.

    ```
    $ http_proxy=http://172.20.0.10:8443 curl http://example.com

    $ ssh -o ProxyCommand="nc -x 172.20.0.10:8443 %h %p" user@example.com
    ```
    
5. Add .ssh/config to use VPN automatically

    ```
    Host *.example.com
      ProxyCommand nc -x 172.20.10:8443 %h %p
      ForwardX11 "yes"
      ForwardAgent "yes"
    ```

## License

[MIT](https://github.com/yownas/docker-fortivpn-socks5/blob/master/LICENSE)
