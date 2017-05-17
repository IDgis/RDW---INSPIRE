#!/bin/bash

if [ -f /var/run/backup.pid ]; then
	if [ -d /proc/$(cat /var/run/backup.pid) ]; then
		echo backup is already running... $(date)
		exit 0
	else
		echo obsolete pid file found: /var/run/backup.pid
	fi
fi

echo $$ > /var/run/backup.pid

echo Performing remote backup: $(date)

# loading settings
. /etc/backup

# copy volume contents to backup folder
rm -r /backup/nginx_logs/*
cp -r /var/log/nginx /backup/nginx_logs
rm -r /backup/awstats_result/*
cp -r /usr/lib/cgi-bin /backup/awstats_result
rm -r /backup/base_atom_data/*
cp -r /usr/share/nginx/html/www/download /backup/base_atom_data
rm -r /backup/geoserver_data/*
cp -r /opt/geoserver/data_dir /backup/geoserver_data

# perform an incremental backup using duplicity:
echo "Performing incremental backup..."
duplicity incremental \
	--allow-source-mismatch \
	--no-encryption \
	--full-if-older-than=1M \
	/backup \
	"$BACKUP_URL"

echo "Removing old backups..."
duplicity remove-older-than \
	--allow-source-mismatch \
	2Y \
	--force \
	"$BACKUP_URL"

# show backup files
echo Backup files:
du -ah /backup/*

# cleanup
rm /var/run/backup.pid 

echo Backup finished: $(date)
