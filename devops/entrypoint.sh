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

# hang execution
tail -f /dev/null

