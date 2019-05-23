# Probo Ubuntu PHP Image
#
# This script builds the PHP containers for ProboCI. It is built off a foundation of tools built in
# mbagnall/probo-lamp:ubuntu-base

# Base this off Ubuntu 18.04
FROM mbagnall/probo-lamp:ubuntu-base

LABEL name="ProboCI PHP Image"
LABEL description="Specific PHP image based on Ubuntu and a base set of tools."
LABEL author="Michael R. Bagnall <mrbagnall@icloud.com>"
LABEL vendor="ProboCI, LLC."

WORKDIR /root

ENV TERM xterm

# Add ondrej/php PPA repository for PHP.
RUN add-apt-repository ppa:ondrej/php \
  && apt update -y

# Install PHP, PHP packages, Postgresql, and Apache2 apt packages.
RUN apt install -y \
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
  php-memcached \
  libapache2-mod-php7.3 \
  php-redis \
  php-imagick \
  php-pear \
  php7.3-dev \
  php7.3-xml 

RUN pecl channel-update pecl.php.net && \
  pecl install mcrypt-1.0.2

# Use or modified php.ini files into position to be used by PHP 7.2. This has the mcrypt
# extension loaded as part of the ini file.
COPY files/php-apache.ini /etc/php/7.3/apache/php.ini
COPY files/php-cli.ini /etc/php/7.3/cli/php.ini

# Install the PhpRedis class
RUN pecl install redis

# Install Composer and Drush
RUN curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/local/bin \
    --filename=composer \
    --version=1.8.5 && \
    composer \
    --working-dir=/usr/local/src/ \
    global \
    require \
    drush/drush:8.* && \
    ln -s /usr/local/src/vendor/bin/drush /usr/local/bin/drush8 && \
    composer \
    --working-dir=/usr/src/ \
    global \
    require \
    drush/drush:9.* && \
    ln -s /usr/src/vendor/bin/drush /usr/local/bin/drush9 && \
    ln -s /usr/local/src/vendor/bin/drush /usr/local/bin/drush

# Download Drupal Console and install it in our standard path.
RUN curl https://drupalconsole.com/installer -L -o /drupal.phar
RUN mv /drupal.phar /bin/drupal
RUN chmod 755 /bin/drupal

# Install WP-CLI Wordpress command line tool, https://wp-cli.org/.
RUN curl -o /tmp/wp-cli.phar https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x /tmp/wp-cli.phar \
  && mv /tmp/wp-cli.phar /usr/local/bin/wp

# Configure Apache. Be sure to enable apache mods or you're going to have a bad time.
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
