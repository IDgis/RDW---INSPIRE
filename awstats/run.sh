#!/bin/bash

service apache2 start

while [ true ] ; 
do
/usr/share/doc/awstats/examples/awstats_updateall.pl now -awstatsprog=/usr/lib/cgi-bin/awstats.pl
sleep 3600
done
