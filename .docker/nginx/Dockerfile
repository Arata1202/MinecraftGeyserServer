FROM nginx:1.28-alpine
ENV TZ=UTC

COPY ./.docker/nginx /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]