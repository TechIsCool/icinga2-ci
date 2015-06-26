# Copyright (C) 2015 @doerteDev

# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License as published by the Free
# Software Foundation, either version 3 of the License, or (at your option)
# any later version.

# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
# more details.

# You should have received a copy of the GNU General Public License along
# with this program.  If not, see <http://www.gnu.org/licenses/>.

# Inheriting from Debian/Wheezy (oldstable)
FROM debian:wheezy

# Hit me on Twitter or xmpp://doertedev@hasameli.com
MAINTAINER doerteDev

# ... pretty obvious.
ENV DEBIAN_FRONTEND noninteractive

# There won't be no icinga key retrieval without openssl/ca-certificates.
RUN apt-get -qq update \
    && apt-get -qqy upgrade \
    && apt-get -qqy install --no-install-recommends wget bash unzip ca-certificates

# Import the key for the official icinga repo
RUN wget --quiet -O - http://packages.icinga.org/icinga.key | apt-key add -

# And included it so apt can query repo for packages.
RUN echo "deb http://packages.icinga.org/debian icinga-wheezy-snapshots main" >> /etc/apt/sources.list

# You could also provide a preferences.d / version pinning file here. But meh.
RUN apt-get -qq update \
    && apt-get -qqy install --no-install-recommends icinga2=2.3.5+snapshot2015.06.25+7~wheezy icinga2=2.3.5+snapshot2015.06.25+7~wheezy \
    && apt-get clean

# Put your icinga2 config volume here.
VOLUME  ["/etc/icinga2"]

# This does the validation on your configs.
ENTRYPOINT /usr/sbin/icinga2 daemon --validate
