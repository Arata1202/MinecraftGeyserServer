FROM amazon/aws-cli:2.26.2

WORKDIR /backup

RUN yum update -y && yum install -y tar gzip

COPY ./.docker/backup/entrypoint.sh .

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
