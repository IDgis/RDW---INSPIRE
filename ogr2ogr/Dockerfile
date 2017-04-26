FROM ubuntu:xenial

MAINTAINER IDgis B.V. <info@idgis.nl>

RUN apt-get update && apt-get install software-properties-common --assume-yes

RUN add-apt-repository ppa:ubuntugis/ppa \
    && apt-get update \
    && apt-get install gdal-bin --assume-yes
# End ogr2ogr install

RUN apt-get install zip --assume-yes

RUN mkdir -p /opt/refresh-scripts

COPY refresh-scripts /opt/refresh-scripts
RUN chmod 755 /opt/refresh-scripts/refresh-data.sh

COPY refresh-data.cron /etc/cron.d

# Keep running
CMD cron && tail -f /dev/null