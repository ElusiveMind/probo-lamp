# Probo Base Ubuntu Image
#
# This is the foundation container for the Probo Ubuntu LAMP/PHP image. It contains the core components for
# Probo. That means it is everything but the specific version of PHP used.
#
# Currently based off Ubuntu 18.04, ths includes all tools such as NodeJS, Perl, Java, Redis, Memcached,
# MariaDB, PostgreSQL, SOLR and Varnish.
#
# PHP containers use this as their foundation.
#
# Base this off Ubuntu 18.04
FROM ubuntu:18.04

# Set our our meta data for this container.
LABEL name="Ubuntu 18.04 LTS Based ProboCI Image"
LABEL description="Our base container for ProboCI Builds."
LABEL author="Michael R. Bagnall <mrbagnall@icloud.com>"
LABEL vendor="ProboCI, LLC."

WORKDIR /root

ENV TERM xterm

# Update apt repos and install base apt packages. Also update to version 10 of NodeJS as 
# support for NodeJS version 8 expires at the end of 2019
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y apt-utils \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    git \
    libnss3 \
    lsb-release \
    memcached \
    nano \
    netcat-openbsd \
    ntp \
    openjdk-8-jre \
    redis-server \
    sendmail \
    software-properties-common \
    sudo \
    vim \
    wget \
    zip \
    pkg-config \
    libgd-dev \
    libmariadbd-dev 

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash \
  && apt-get -y update \
  && apt-get -y install gcc g++ make \
  && apt-get -y install nodejs
  && apt-get -y install npm

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
  libmcrypt-dev \
  google-chrome-stable

# Install Proboscis
RUN npm install -g proboscis

# Install NPM Packages.
RUN npm install -g bower \
  grunt-cli \
  gulp-cli \
  lighthouse \
  the-a11y-machine

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
COPY files/mysql-setup.sql /mysql-setup.sql
RUN apt-get install -y mariadb-server mariadb-client \
  && service mysql start \
  && mysql -uroot < /mysql-setup.sql

# Install Ruby and Gem packages.
RUN apt-get install -y libreadline-dev zlib1g-dev ruby-dev libsqlite3-dev \
  && gem install rails \
  && gem install mailcatcher \
  && gem install compass \
  && gem install bundler

# Install solr with default search cores.
RUN wget http://archive.apache.org/dist/lucene/solr/6.6.5/solr-6.6.5.tgz \
  && tar xzf solr-6.6.5.tgz solr-6.6.5/bin/install_solr_service.sh --strip-components=2 \
  && ./install_solr_service.sh solr-6.6.5.tgz  \
  && wget https://ftp.drupal.org/files/projects/search_api_solr-7.x-1.14.tar.gz \
  && tar xzf search_api_solr-7.x-1.14.tar.gz \
  && mv search_api_solr /opt/solr/. \
  && sudo -u solr -- /opt/solr/bin/solr create -c drupal7 -d "/opt/solr/search_api_solr/solr-conf/6.x" \
  && wget https://ftp.drupal.org/files/projects/search_api_solr-8.x-2.7.tar.gz \
  && rm -rf /opt/solr/search_api_solr \
  && tar xzf search_api_solr-8.x-2.7.tar.gz \
  && mv search_api_solr /opt/solr/. \
  && sudo -u solr -- /opt/solr/bin/solr create -c drupal8 -d "/opt/solr/search_api_solr/solr-conf/6.x" \
  && service solr stop

# Create .ssh dir and add SSH config file.
# TODO: There's got to be a better way to setup the /root/.ssh/config file. Using old method for now.
RUN mkdir /root/.ssh \
  && chmod 700 /root/.ssh \
  && touch /root/.ssh/config \
  && chmod 0700 /root/.ssh/config \
  && echo "Host *" >> /root/.ssh/config \
  && echo "StrictHostKeyChecking no" >> /root/.ssh/config

# Final Perl modules that do not have apt installers.
RUN cpan -i GD::Image && \
  cpan -i ExtUtils::PkgConfig && \
  cpan -i Crypt::Blowfish && \
  cpan -i HTTP::Request && \
  cpan -i Test::More && \
  cpan -i Image::Resize && \
  cpan -i CGI && \
  cpan -i CGI::Carp && \
  cpan -i YAML && \
  cpan -T Class::HPLOO && \
  cpan -T HDB && \
  cpan -T DBD && \
  cpan -i DBI && \
  cpan -i Net::HTTP && \
  cpan -i URI && \
  cpan -i Net:SMTPS && \
  cpan -i JSON && \
  cpan -i File::MimeInfo && \
  cpan -i HTTP::Request::AsCGI \ 
  cpan -i LWP::Protocol::https
