FROM amazon/aws-cli:2.26.2

WORKDIR /backup

RUN apt-get update

COPY ./.bin/backup.sh .

RUN chmod +x ./backup.sh

CMD ["./backup.sh"]
