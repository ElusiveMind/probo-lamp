# Probo Ubuntu PHP Image
#
# This script builds the PHP containers for ProboCI. It is built off a foundation of tools built in
# mbagnall/probo-lamp:ubuntu-base

# Base this off Ubuntu 20.04
FROM mbagnall/probo-lamp:linux

LABEL name="ProboCI PHP Image"
LABEL description="Unified ProboCI Image. All versions of PHP available via yaml configuration."
LABEL author="Michael R. Bagnall <mbagbnall@zivtech.com>"
LABEL vendor="ProboCI, LLC."

WORKDIR /root

ENV TERM xterm

# Add ondrej/php PPA repository for PHP.
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update -y \
  && apt-get install dialog

# Start and configure our MySQL Server
 RUN apt-get update -y
 COPY files/mysql-setup.sql /mysql-setup.sql
 COPY files/probo.cnf .my.cnf
 RUN apt-get install -y mysql-server mysql-client \
   && service mysql start \
   && mysql -uroot < /mysql-setup.sql

# Install PHP, PHP packages, Postgresql, and Apache2 apt packages.
RUN apt-get install -y \
  php5.6 \
  php5.6-bcmath \
  php5.6-bz2 \
  php5.6-cli \
  php5.6-common \
  php5.6-curl \
  php5.6-dba \
  php5.6-gd \
  php5.6-json \
  php5.6-ldap \
  php5.6-mbstring \
  php5.6-mcrypt \
  php5.6-mysql \
  php5.6-opcache \
  php5.6-readline \
  php5.6-soap \
  php5.6-zip \
  php5.6-pgsql \
  php5.6-dev \
  php5.6-xml \
  libapache2-mod-php5.6

# Install PHP.
RUN apt-get install -y \
  php7.0 \
  php7.0-bcmath \
  php7.0-bz2 \
  php7.0-cli \
  php7.0-common \
  php7.0-curl \
  php7.0-dba \
  php7.0-gd \
  php7.0-json \
  php7.0-ldap \
  php7.0-mbstring \
  php7.0-mcrypt \
  php7.0-mysql \
  php7.0-opcache \
  php7.0-readline \
  php7.0-soap \
  php7.0-zip \
  php7.0-pgsql \
  php7.0-dev \
  php7.0-xml \
  libapache2-mod-php7.0

# Install PHP, PHP packages, Postgresql, and Apache2 apt packages.
RUN apt-get install -y \
  php7.1 \
  php7.1-bcmath \
  php7.1-bz2 \
  php7.1-cli \
  php7.1-common \
  php7.1-curl \
  php7.1-dba \
  php7.1-gd \
  php7.1-json \
  php7.1-ldap \
  php7.1-mbstring \
  php7.1-mysql \
  php7.1-mcrypt \
  php7.1-opcache \
  php7.1-readline \
  php7.1-soap \
  php7.1-xml \
  php7.1-zip \
  php7.1-pgsql \
  php7.1-dev \
  php7.1-xml \
  libapache2-mod-php7.1

RUN apt-get install -y \
  php7.2 \
  php7.2-bcmath \
  php7.2-bz2 \
  php7.2-cli \
  php7.2-common \
  php7.2-curl \
  php7.2-dba \
  php7.2-gd \
  php7.2-json \
  php7.2-ldap \
  php7.2-mbstring \
  php7.2-mysql \
  php7.2-opcache \
  php7.2-readline \
  php7.2-soap \
  php7.2-zip \
  php7.2-pgsql \
  php7.2-dev \
  php7.2-xml \
  libapache2-mod-php7.2

RUN apt-get install -y \
  php7.3 \
  php7.3-bcmath \
  php7.3-bz2 \
  php7.3-cli \
  php7.3-common \
  php7.3-curl \
  php7.3-dba \
  php7.3-gd \
  php7.3-json \
  php7.3-ldap \
  php7.3-mbstring \
  php7.3-mysql \
  php7.3-opcache \
  php7.3-readline \
  php7.3-soap \
  php7.3-zip \
  php7.3-pgsql \
  php7.3-dev \
  php7.3-xml \
  libapache2-mod-php7.3

RUN apt-get install -y \
  php7.4 \
  php7.4-bcmath \
  php7.4-bz2 \
  php7.4-cli \
  php7.4-common \
  php7.4-curl \
  php7.4-dba \
  php7.4-gd \
  php7.4-json \
  php7.4-ldap \
  php7.4-mbstring \
  php7.4-mysql \
  php7.4-opcache \
  php7.4-readline \
  php7.4-soap \
  php7.4-zip \
  php7.4-pgsql \
  php7.4-dev \
  php7.4-xml \
  libapache2-mod-php7.4

RUN apt-get install -y \
  php8.0 \
  php8.0-bcmath \
  php8.0-bz2 \
  php8.0-cli \
  php8.0-common \
  php8.0-curl \
  php8.0-dba \
  php8.0-gd \
  php8.0-ldap \
  php8.0-mbstring \
  php8.0-mysql \
  php8.0-opcache \
  php8.0-readline \
  php8.0-soap \
  php8.0-zip \
  php8.0-pgsql \
  php8.0-dev \
  php8.0-xml \
  libapache2-mod-php8.0

RUN update-alternatives --set php /usr/bin/php7.3 && \
  a2dismod php5.6 && \
  a2dismod php7.0 && \
  a2dismod php7.1 && \
  a2dismod php7.2 && \
  a2dismod php7.3 && \
  a2dismod php7.4 && \
  a2dismod php8.0 && \
  service apache2 restart

RUN apt-get install -y \
  php-redis \
  php-imagick \
  php-pear \
  php-memcached

RUN pecl channel-update pecl.php.net && \
  pecl install redis && \
  pear install PHP_CodeSniffer

# Install Terminus Pantheon command line tool, https://pantheon.io/docs/terminus.
RUN mkdir ~/terminus && cd ~/terminus \
  && curl -L https://github.com/pantheon-systems/terminus/releases/download/$(curl --silent "https://api.github.com/repos/pantheon-systems/terminus/releases/latest" | perl -nle'print $& while m{"tag_name": "\K.*?(?=")}g')/terminus.phar --output terminus \
  && chmod +x terminus \
  && ln -s ~/terminus/terminus /usr/local/bin/terminus

# Install WP-CLI Wordpress command line tool, https://wp-cli.org/.
RUN curl -o /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x /tmp/wp-cli.phar \
  && mv /tmp/wp-cli.phar /usr/local/bin/wp

# Configure Apache. Be sure to enable apache mods or you're going to have a bad time.
COPY files/ssl_environment_variable.conf /etc/apache2/conf-enabled/ssl_environment_variable.conf
RUN rm -rf /var/www/html \
  && a2enmod rewrite \
  && a2enmod actions \
  && a2enmod alias \
  && a2enmod deflate \
  && a2enmod dir \
  && a2enmod expires \
  && a2enmod headers \
  && a2enmod mime \
  && a2enmod negotiation \
  && a2enmod setenvif \
  && a2enmod proxy \
  && a2enmod proxy_http \
  && a2enmod speling
COPY files/apache-default-host.conf /etc/apache2/conf-enabled/apache-default-host.conf

# Install composer and drush.
RUN mkdir /usr/local/src/drush9
RUN mkdir /usr/local/src/drush8
RUN mkdir /usr/local/src/drush-launcher
RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/local/bin \
  --filename=composer \
  && composer \
  --working-dir=/usr/local/src/drush9 \
  global \
  require \
  drush/drush:9.* \
  && composer \
  --working-dir=/usr/local/src/drush8 \
  global \
  require \
  drush/drush:8.* \
  && mkdir /etc/drush \
  && mkdir /etc/drush/conf.d
RUN wget -O /usr/local/src/drush-launcher/drush https://github.com/drush-ops/drush-launcher/releases/latest/download/drush.phar
RUN chmod +x /usr/local/src/drush-launcher/drush
