FROM ubuntu:latest

ENV APP_HOME="/app"

RUN apt update && \
    DEBIAN_FRONTEND=noninteractive apt install tor openssh-server -y

COPY devops/torrc /etc/tor/torrc
COPY devops/entrypoint.sh "$APP_HOME/entrypoint.sh"

WORKDIR "$APP_HOME"
ENTRYPOINT ["/bin/bash", "entrypoint.sh"]
