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
COPY init.sh /opt/
RUN chmod 755 /opt/init.sh
RUN chmod 755 /opt/refresh-scripts/refresh-data.sh

# Multiple reasons why crontab files are not working: https://askubuntu.com/questions/23009/why-crontab-scripts-are-not-working

#install rsyslog to capture cron log in /var/log/cron.log
RUN apt-get update \
    && apt-get install rsyslog --assume-yes \
    && sed 's/^#cron/cron/' </etc/rsyslog.d/50-default.conf >/etc/rsyslog.d/50-default.conf.tmp \
    && mv /etc/rsyslog.d/50-default.conf.tmp /etc/rsyslog.d/50-default.conf
    
#install cron    
RUN apt-get update \
    && apt-get install cron
    
#overwrite default contab file (unclear why a cron file in cron.d is not read)
COPY crontab /etc/crontab
RUN chmod 0644 /etc/crontab
# Create the log file to be able to run tail
RUN touch /opt/refresh-scripts/refresh-data.log

# Keep running
CMD /opt/init.sh
