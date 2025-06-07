FROM ubuntu:25.10

WORKDIR /cron

RUN apt-get update && apt-get install -y cron

COPY .docker/cron/crontab /etc/cron.d/active
COPY .docker/cron/active.sh .

RUN chmod 0644 /etc/cron.d/active
RUN chmod +x ./active.sh

CMD ["cron", "-f"]