FROM nginx:1.25-alpine

RUN apk add --no-cache gettext

COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /entrypoint.sh

ENV APP_VERSION=v1
ENV APP_ENV=demo

EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
