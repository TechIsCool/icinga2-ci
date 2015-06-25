FROM debian:wheezy

MAINTAINER doerteDev

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -qq update \
    && apt-get -qqy upgrade \
    && apt-get -qqy install --no-install-recommends wget bash unzip ca-certificates
RUN wget --quiet -O - http://packages.icinga.org/icinga.key | apt-key add -
RUN echo "deb http://packages.icinga.org/debian icinga-wheezy-snapshots main" >> /etc/apt/sources.list
RUN apt-get -qq update \
    && apt-get -qqy install --no-install-recommends icinga2=2.3.5+snapshot2015.06.25+7~wheezy icinga2=2.3.5+snapshot2015.06.25+7~wheezy \
    && apt-get clean

VOLUME  ["/etc/icinga2"]

ENTRYPOINT /usr/sbin/icinga2 daemon --validate
