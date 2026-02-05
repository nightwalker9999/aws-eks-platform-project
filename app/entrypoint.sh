#!/usr/bin/env sh
set -e

: "${APP_VERSION:=v1}"
: "${APP_ENV:=demo}"

envsubst '${APP_VERSION} ${APP_ENV} ${HOSTNAME}' \
  < /usr/share/nginx/html/index.html \
  > /usr/share/nginx/html/index.rendered.html

mv /usr/share/nginx/html/index.rendered.html /usr/share/nginx/html/index.html

exec nginx -g 'daemon off;'
