FROM amazon/aws-cli:2.26.2

WORKDIR /route53

RUN yum update -y && yum install -y curl

COPY ./.docker/route53/entrypoint.sh .

RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
