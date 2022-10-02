Use this tool to deploy an SSH service and make it accessible through Tor.

## Usage (server)

Install `docker` and `docker-compose`:

```bash
apt install docker.io docker-compose -y
```

Optional step - set SSH credentials (darkshell will use default ones if you omit this step):

```bash
export DARKSHELL_USER="scrubbed"
export DARKSHELL_PASS="scrubbed"
```

Build and run darkshell:

```bash
docker-compose -f ./devops/docker-compose.yml build
docker-compose -f ./devops/docker-compose.yml up --detach
```

Once the server starts, you should see the onion hostname printed in the logs.

Note: you can use the following command for reading the logs:

```bash
$ docker logs darkshell
...
 * Restarting OpenBSD Secure Shell server sshd
   ...done.
 * Starting tor daemon...
   ...done.
---
darkshell has been initialized

Hostname: scrubbed.onion

SSH command: torsocks ssh hexenbucht@scrubbed.onion
Password: hexenbucht

---
You may want to add the following entry to your client's SSH config:

# Media host as Tor hidden service
host hidden
  hostname h5daobfr6mydsl2hzgh63peuhlz734hb3wiep57356vooxlz7bmgopad.onion
  Compression yes
  Protocol 2
  PreferredAuthentications password
  proxyCommand ncat --proxy 127.0.0.1:9050 --proxy-type socks5 %h %p
```

You might need to wait a few minutes before darkshell becomes reachable.

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

