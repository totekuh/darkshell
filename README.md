Use this tool to deploy an SSH service and make it accessible through Tor.

## Usage (server)

Install Docker:

```bash
apt install docker.io docker-compose -y
```

Optional step - set SSH credentials (darkshell will use default ones if you omit this step):

```bash
export DARKSHELL_USER="your_username"
export DARKSHELL_PASS="your_pass"
```

Build and run darkshell with Docker:

```bash
docker-compose -f ./devops/docker-compose.yml build
docker-compose -f ./devops/docker-compose.yml up --detach
```

Once the server starts, you should see the onion hostname printed on the logs.

Note: you can use the following command for reading the logs:

```bash
docker logs darkshell
```

Tor might need a few minutes before it makes your service available.

## Usage (client)

Install `tor` and `ncat`:

```bash
apt update
apt install tor ncat -y
```

Start the Tor service:

```bash
systemctl start tor
```

Add the following statement with the hostname to your local SSH config (`~/.ssh/config`):

```bash
# Media host as Tor hidden service
host hidden
  hostname <your_onion_hostname>
  Compression yes
  Protocol 2
  PreferredAuthentications password
  proxyCommand ncat --proxy 127.0.0.1:9050 --proxy-type socks5 %h %p
```

Access the service via Tor using the password `hexenbucht`:

```bash
ssh hexenbucht@hidden
```

