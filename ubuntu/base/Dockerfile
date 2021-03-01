# Probo Base Ubuntu Image
#
# This is the foundation container for the Probo Ubuntu LAMP/PHP image. It contains the core components for
# Probo. That means it is everything but the specific version of PHP used.
#
# Currently based off Ubuntu 20.04, ths includes all tools such as NodeJS, Perl, Java, Redis, Memcached,
# MySQL, PostgreSQL, SOLR and Varnish.
#
# PHP containers use this as their foundation.
#
# Base this off Ubuntu 20.04
FROM ubuntu:20.04

# Set our our meta data for this container.
LABEL name="Ubuntu 20.04 LTS Based ProboCI Image"
LABEL description="Our base container for ProboCI Builds."
LABEL author="Michael R. Bagnall <mbagnall@zivtech.com>"
LABEL vendor="ProboCI, LLC."

WORKDIR /root

ENV TERM xterm

RUN apt-get -y update
RUN apt-get -y install curl dirmngr apt-transport-https lsb-release ca-certificates sudo apt-utils
RUN curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash

# Update apt repos and install base apt packages. Also update to version 10 of NodeJS as 
# support for NodeJS version 8 expires at the end of 2019
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
  build-essential \
  git \
  gnupg \
  libnss3 \
  memcached \
  nano \
  netcat-openbsd \
  nodejs \
  ntp \
  openjdk-8-jre \
  redis-server \
  sendmail \
  software-properties-common \
  sudo \
  vim \
  wget \
  zip \
  gcc \
  g++ \
  make \
  cpanminus

RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
  && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
  && apt-get -y update \
  && apt-get -y install yarn

# Add google-chrome-stable apt-key.
RUN curl -o /tmp/linux_signing_key.pub https://dl-ssl.google.com/linux/linux_signing_key.pub \
  && apt-key add /tmp/linux_signing_key.pub \
  && echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | tee /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update

# Install PHP, PHP packages, Postgresql, and Apache2 apt packages.
RUN apt-get install -y \
  imagemagick \
  postgresql \
  postgresql-contrib \
  apache2 \
  apache2-utils \
  google-chrome-stable

# Install Proboscis
RUN npm install -g proboscis --unsafe

# Install NPM Packages.
RUN npm install -g bower \
  grunt-cli \
  gulp-cli \
  lighthouse \
  --no-document

# Start and configure our PostgreSQL server
COPY files/pgpass.txt /root/.pgpass
RUN chmod 600 /root/.pgpass \
  && service postgresql start \
  && su - postgres -c "createuser -d -l -r -s root" \
  && su - postgres -c "createdb --owner=postgres drupal" \
  && psql --username=root --dbname=drupal -c "ALTER USER root WITH PASSWORD 'strongpassword';" \
  && chmod 600 /root/.pgpass \
  && service postgresql stop

# Start and configure our MySQL Server
RUN apt-get update -y
RUN apt -y install libaio1 libtinfo5 psmisc libmecab2 libnuma1
RUN wget https://downloads.mysql.com/archives/get/p/23/file/mysql-common_5.7.32-1ubuntu18.04_amd64.deb
RUN wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-server_5.7.32-1ubuntu18.04_amd64.deb
RUN wget https://downloads.mysql.com/archives/get/p/23/file/mysql-client_5.7.32-1ubuntu18.04_amd64.deb
RUN wget https://downloads.mysql.com/archives/get/p/23/file/mysql-community-client_5.7.32-1ubuntu18.04_amd64.deb

RUN dpkg -i mysql-common_5.7.32-1ubuntu18.04_amd64.deb
RUN dpkg -i mysql-community-client_5.7.32-1ubuntu18.04_amd64.deb
RUN dpkg -i mysql-client_5.7.32-1ubuntu18.04_amd64.deb
RUN dpkg -i mysql-community-server_5.7.32-1ubuntu18.04_amd64.deb

# Install Ruby and Gem packages.
RUN apt-get install -y libreadline-dev zlib1g-dev ruby-dev libsqlite3-dev \
  && gem install rails \
    mailcatcher \
    compass \
    bundler \
    --no-document

# Install solr with default search cores.
RUN wget http://archive.apache.org/dist/lucene/solr/7.7.3/solr-7.7.3.tgz \
  && tar xzf solr-7.7.3.tgz solr-7.7.3/bin/install_solr_service.sh --strip-components=2 \
  && ./install_solr_service.sh solr-7.7.3.tgz  \
  && wget https://ftp.drupal.org/files/projects/search_api_solr-7.x-1.15.tar.gz \
  && tar xzf search_api_solr-7.x-1.15.tar.gz \
  && mv search_api_solr /opt/solr/. \
  && sudo -u solr -- /opt/solr/bin/solr create -c drupal7 -d "/opt/solr/search_api_solr/solr-conf/7.x" \
  && wget https://ftp.drupal.org/files/projects/search_api_solr-4.1.4.tar.gz \
  && rm -rf /opt/solr/search_api_solr \
  && tar xzf search_api_solr-4.1.4.tar.gz \
  && mv search_api_solr /opt/solr/. \
  && sudo -u solr -- /opt/solr/bin/solr create -c drupal8 -d "/opt/solr/search_api_solr/jump-start/solr7/config-set" \
  && sudo -u solr -- /opt/solr/bin/solr create -c drupal9 -d "/opt/solr/search_api_solr/jump-start/solr7/config-set" \
  && service solr stop

# Install varnish with default config.
COPY files/varnishcache_varnish41.list /etc/apt/sources.list.d/varnishcache_varnish41.list
RUN curl -L https://packagecloud.io/varnishcache/varnish41/gpgkey | apt-key add -
RUN apt-add-repository universe \
  && apt-get update -y \
  && apt-get install -y debian-archive-keyring \
  && apt-get update -y \
  && apt-get install -y varnish

# Install varnish default configs.
COPY files/wordpress-default-4.vcl /etc/varnish/wordpress-default.vcl
COPY files/drupal-default-4.vcl /etc/varnish/drupal-default.vcl
COPY files/default-4.vcl /etc/varnish/default.vcl
COPY files/varnish /etc/default/varnish
COPY files/secret /etc/varnish/secret

# Create .ssh dir and add SSH config file.
# TODO: There's got to be a better way to setup the /root/.ssh/config file. Using old method for now.
RUN mkdir /root/.ssh \
  && chmod 700 /root/.ssh \
  && touch /root/.ssh/config \
  && chmod 0700 /root/.ssh/config \
  && echo "Host *" >> /root/.ssh/config \
  && echo "StrictHostKeyChecking no" >> /root/.ssh/config
