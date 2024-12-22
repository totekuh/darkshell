FROM ubuntu:latest

ENV APP_HOME="/app"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install tor openssh-server -y

COPY devops/torrc /etc/tor/torrc
COPY devops/entrypoint.sh "$APP_HOME/entrypoint.sh"
COPY devops/server-linux64 /usr/bin/chat-server
COPY devops/client-linux64 /usr/bin/chat-client

COPY devops/chatapp /etc/init.d/chatapp

RUN chmod -x /etc/update-motd.d/* && \
    rm -rf /etc/motd /etc/legal && \
    mkdir /var/lib/tor/ssh

COPY devops/banner.txt /etc/motd

WORKDIR "$APP_HOME"
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
