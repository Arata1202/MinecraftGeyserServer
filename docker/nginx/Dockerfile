FROM nginx:1.28-alpine
ENV TZ=UTC

RUN apk add --no-cache apache2-utils

COPY ./.docker/nginx /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]