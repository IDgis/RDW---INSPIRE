FROM nginx

COPY default.conf /etc/nginx/conf.d/

COPY download /usr/share/nginx/html/www/download/

RUN mkdir -p /usr/share/nginx/html/schemas

COPY schemas /usr/share/nginx/html/schemas