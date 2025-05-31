FROM eclipse-temurin:21-jdk

WORKDIR /server

RUN apt-get update && apt-get install -y curl jq

COPY . .

RUN chmod +x ./.docker/entrypoint.sh
RUN chmod +x ./.bin/start.sh

EXPOSE 19132
EXPOSE 25565
EXPOSE 25575
EXPOSE 8123

ENTRYPOINT ["./.docker/entrypoint.sh"]
CMD ["./.bin/start.sh"]
