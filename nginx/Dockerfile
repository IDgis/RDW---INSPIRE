FROM nginx:1.15
LABEL maintainer="IDgis bv"

RUN mkdir -p /usr/share/nginx/html/schemas && \
    mkdir -p /var/log/nginx/rdw

COPY default.conf /etc/nginx/conf.d/
COPY download /usr/share/nginx/html/www/download/
COPY schemas /usr/share/nginx/html/schemas/
