FROM ubuntu:xenial

RUN apt-get -y update && \
	apt-get install -y \
		apache2 \
		awstats \
		gettext

# Copy master conf file. This file has the default content + a value for SiteDomain 
COPY awstats.conf /etc/awstats/awstats.conf
COPY awstats.inspire.rdw.nl.conf /etc/awstats/awstats.inspire.rdw.nl.conf
COPY 000-default.conf /etc/apache2/sites-available/
COPY run.sh /
RUN chmod a+x /run.sh

RUN a2enmod cgi
RUN a2ensite 000-default

CMD /run.sh