FROM ubuntu:xenial
LABEL maintainer="IDgis bv"

RUN mkdir -p /usr/share/nginx/html/schemas && \
    mkdir -p /usr/share/nginx/html/www/download

COPY download /usr/share/nginx/html/www/download/
COPY schemas /usr/share/nginx/html/schemas

VOLUME /usr/share/nginx/html/schemas
VOLUME /usr/share/nginx/html/www/download
