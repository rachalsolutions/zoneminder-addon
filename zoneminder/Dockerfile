# ARG BUILD_FROM
# FROM $BUILD_FROM
FROM ubuntu:18.04

# Update base packages
RUN apt update \
    && apt upgrade --assume-yes

# Install pre-reqs
RUN apt install --assume-yes --no-install-recommends gnupg

# Configure Zoneminder PPA
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ABE4C7F993453843F0AEB8154D0BF748776FFB04 \
    && echo deb http://ppa.launchpad.net/iconnor/zoneminder-1.36/ubuntu bionic main > /etc/apt/sources.list.d/zoneminder.list \
    && apt update

# Install zoneminder
RUN DEBIAN_FRONTEND=noninteractive apt install --assume-yes zoneminder jq iputils-ping \
    && a2enconf zoneminder \
    && a2enmod rewrite cgi

# Setup Volumes
VOLUME /var/cache/zoneminder/events /var/cache/zoneminder/images /var/lib/mysql /var/log/zm

# Expose http port
EXPOSE 80

# Get the entrypoint script
ADD https://raw.githubusercontent.com/ZoneMinder/zmdockerfiles/master/utils/entrypoint.sh /usr/local/bin/
RUN chmod 755 /usr/local/bin/entrypoint.sh

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
