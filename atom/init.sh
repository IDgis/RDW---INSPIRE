#!/bin/bash

mkdir -p /usr/share/nginx/html/www/download
mkdir -p /usr/share/nginx/html/schemas

cp -r /opt/download /usr/share/nginx/html/www
cp -r /opt/schemas /usr/share/nginx/html
