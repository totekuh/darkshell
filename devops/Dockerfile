FROM ubuntu:latest

ENV APP_HOME="/app"
ENV USER="hexenbucht"
ENV PASS="hexenbucht"


RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install tor openssh-server -y

COPY devops/torrc /etc/tor/torrc
COPY devops/entrypoint.sh "$APP_HOME/entrypoint.sh"

RUN useradd -m -p $(openssl passwd -1 $PASS) $USER

WORKDIR "$APP_HOME"
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
