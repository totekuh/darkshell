#!/bin/bash

export RUNLEVEL=1

# regenerate host SSH keys
rm -rf /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server

service ssh restart

chown debian-tor:debian-tor /var/lib/tor/ssh
chown debian-tor:debian-tor /var/lib/tor/ssh -R

chmod 0700 /var/lib/tor/ssh
chmod 0700 /var/lib/tor/ssh -R

# start tor
service tor start || exit 1

# print the Onion hostname
HOST=$(cat /var/lib/tor/ssh/hostname)

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
echo "  proxyCommand ncat --proxy 127.0.0.1:9050 --proxy-type socks5 %h %p"


# hang execution
tail -f /dev/null

