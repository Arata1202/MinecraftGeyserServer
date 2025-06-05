FROM amazon/aws-cli:2.26.2

WORKDIR /backup

RUN yum update -y && yum install -y tar gzip

COPY ./.bin/backup.sh .

RUN chmod +x ./backup.sh

ENTRYPOINT ["./backup.sh"]
