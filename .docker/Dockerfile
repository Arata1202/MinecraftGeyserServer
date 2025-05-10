FROM eclipse-temurin:21-jdk

WORKDIR /server

RUN apt-get update && apt-get install -y curl jq make git gcc \
    && git clone https://github.com/Tiiffi/mcrcon.git /tmp/mcrcon \
    && cd /tmp/mcrcon \
    && make \
    && cp mcrcon /usr/local/bin \
    && rm -rf /tmp/mcrcon

COPY . .

RUN chmod +x ./.docker/entrypoint.sh

EXPOSE 19132
EXPOSE 25565
EXPOSE 25575

CMD ["./.docker/entrypoint.sh"]
