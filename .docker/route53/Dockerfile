FROM amazon/aws-cli:2.26.2

WORKDIR /route53

RUN yum update -y && yum install -y curl

COPY ./.aws/route53.sh .

RUN chmod +x ./route53.sh

ENTRYPOINT ["./route53.sh"]
