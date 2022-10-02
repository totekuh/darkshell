#!/bin/bash

export RUNLEVEL=1

if [[ -z "${DARKSHELL_USER}" ]]; then
  USER="hexenbucht"
else
  USER="${DARKSHELL_USER}"
fi

if [[ -z "${DARKSHELL_PASS}" ]]; then
  PASS="hexenbucht"
else
  PASS="${DARKSHELL_PASS}"
fi

# regenerate host SSH keys
rm -rf /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

service ssh restart

useradd -m -p $(openssl passwd -1 $PASS) $USER

chown debian-tor:debian-tor /var/lib/tor/ssh
chown debian-tor:debian-tor /var/lib/tor/ssh -R

chmod 0700 /var/lib/tor/ssh
chmod 0700 /var/lib/tor/ssh -R

# start tor
service tor start || exit 1

# print the Onion hostname
HOST=$(cat /var/lib/tor/ssh/hostname)

echo "---"
echo "darkshell has been initialized"
echo
echo "Hostname: $HOST"

echo
echo "SSH command: torsocks ssh $USER@$HOST"
echo "Password: $PASS"

echo
echo "---"
echo "You may want to add the following entry to your client's SSH config:"
echo 
echo "# Media host as Tor hidden service"
echo "host hidden"
echo "  hostname $HOST"
echo "  Compression yes"
echo "  Protocol 2"
echo "  PreferredAuthentications password"
echo "  proxyCommand ncat --proxy 127.0.0.1:9050 --proxy-type socks5 %h %p"


# hang execution
tail -f /dev/null

