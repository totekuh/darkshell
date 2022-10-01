## General Information

Use this tool to deploy an SSH service accessible via Tor.

## Usage (server)

Build and run with Docker:

```bash
docker-compose -f ./devops/docker-compose.yml build
docker-compose -f ./devops/docker-compose.yml up --detach
```

Once the server starts, you should see the onion hostname printed on the logs.

Note: you can use the following command for reading the logs:

```bash
docker logs darkshell
```

## Usage (client)

Start the Tor service:

```bash
systemctl start tor
```

Add the following statement with the hostname to your local SSH config (`~/.ssh/config`):

```bash
# Media host as Tor hidden service
host hidden
   hostname <your_onion_hostname>
   proxyCommand ncat --proxy 127.0.0.1:9050 --proxy-type socks5 %h %p
```

Access the service via Tor:

```bash
ssh hexenbucht@hidden
```

