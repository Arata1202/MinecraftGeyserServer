FROM eclipse-temurin:21-jdk

WORKDIR /server

RUN apt-get update && apt-get install -y curl jq

COPY . .

RUN chmod +x ./.docker/minecraft/entrypoint.sh
RUN chmod +x ./.docker/minecraft/cmd.sh

EXPOSE 19132
EXPOSE 25565
EXPOSE 25575
EXPOSE 8123

ENTRYPOINT ["./.docker/minecraft/entrypoint.sh"]
CMD ["./.docker/minecraft/cmd.sh"]
