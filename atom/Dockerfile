FROM ubuntu:xenial
LABEL maintainer="IDgis bv"

RUN mkdir -p /opt/download && \
    mkdir -p /opt/schemas

COPY download /opt/download/
COPY schemas /opt/schemas/
COPY init.sh /opt/

RUN chmod a+x /opt/init.sh

VOLUME /usr/share/nginx/html/schemas
VOLUME /usr/share/nginx/html/www/download

CMD ["/opt/init.sh"]
