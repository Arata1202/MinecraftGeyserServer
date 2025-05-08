FROM eclipse-temurin:21-jdk

WORKDIR /server

RUN apt-get update && apt-get install -y curl jq make screen

COPY . .

RUN chmod +x ./.docker/entrypoint.sh

EXPOSE 19132
EXPOSE 25565

ENTRYPOINT ["./.docker/entrypoint.sh"]
CMD ["java", "-Xmx2G", "-Xms2G", "-jar", "Paper.jar"]
