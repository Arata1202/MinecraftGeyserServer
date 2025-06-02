FROM nginx:1.28-alpine
ENV TZ=UTC

WORKDIR /dist

COPY ./.docker/nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]