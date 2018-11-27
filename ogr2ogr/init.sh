#!/bin/bash

echo HALE_IMAGE_VERSION=$HALE_IMAGE_VERSION >> /opt/refresh-scripts/refresh-data.ini
echo NETWORK_NAME=$NETWORK_NAME >> /opt/refresh-scripts/refresh-data.ini
echo NGINX_CONTAINER=$NGINX_CONTAINER >> /opt/refresh-scripts/refresh-data.ini

service rsyslog restart && cron && tail -f /opt/refresh-scripts/refresh-data.log
