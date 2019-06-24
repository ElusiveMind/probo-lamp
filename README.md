# Probo.CI Docker Images

This repository is used to store Linux and PHP specific versions and configuration settings for building automated image builds on the Docker Hub.

The images built from this repository are developed specifically to be used as Docker images that run the builds for [Probo.CI](https://probo.ci).

Support Linux distributions include Ubuntu 18.04 LTS and CentOS 7 are located in their respective version directories.

Note that the base containers contain the standard components for the images. The containers specific to their PHP versions are located in the respective versions in the `php` folder located inside the distribution folder.

The Probo Ubuntu Docker images and tags built are located on the Docker Hub at: [https://hub.docker.com/u/mbagnall/probo-lamp](https://hub.docker.com/u/mbagnall/probo-lamp).

## Apache Version
- Apache 2.4.29 (Default)
  - Apache 2.4.29 Modules Enabled
    - rewrite
    - actions
    - alias
    - deflate
    - dir
    - expires
    - headers
    - mime
    - negotiation
    - setenvif
    - proxy
    - proxy-http

## MySQL Version (MariaDB)
- MariaDB 10.1.38

## PHP Versions Supported
PHP is installed from the `ondrej/php` PPA repository, https://launchpad.net/~ondrej/+archive/ubuntu/php.

- PHP 5.6 (Deprecated)
- PHP 7.0
- PHP 7.1
- PHP 7.2 (Default)
  - PHP 7.2 Extension Packages Installed
    - php7.2-bcmath
    - php7.2-bz2
    - php7.2-cli
    - php7.2-common
    - php7.2-curl
    - php7.2-dba
    - php7.2-dev
    - php7.2-gd
    - php7.2-json
    - php7.2-ldap
    - php7.2-mbstring
    - php7.2-mysql
    - php7.2-opcache
    - php7.2-readline
    - php7.2-soap
    - php7.2-xml
    - php7.2-zip
    - php7.2-pgsql
    - php-memcached
    - libapache2-mod-php7.2
    - php-redis
    - php-imagick
    - php-pear
    - mcrypt-1.0.1
- PHP 7.3
	- same as PHP 7.2 except for mcrypt-1.0.2

## Node.JS Version
- Node 10.x

## PostgreSQL Version
- PostgreSQL 10.8

## Ruby Version
- Ruby 2.x (Default)

## Solr Version
- Apache Solr 6.x (Default)
  - Search API Solr module installed for Drupal 7 and Drupal 8.
  - Default Solr cores available for Drupal 7 and Drupal 8.
    - drupal7
    - drupal8

## Additional Packages and Tools
The following packages and tools have been installed to all Probo Images to allow for additional functionality on images for building and testing web applications out of the box.

- bundler
- composer
- cpanminus (cpanm)
- curl
- drupalconsole
- drush
- git
- google-chrome-stable
- grunt-cli
- gulp-cli
- imagemagick
- lighthouse
- memcached
- mailcatcher
- nano
- netcat-openbsd
- npm
- ntp
- openjdk-8-jre
- rails
- redis-server
- compass
- sendmail
- vim
- wget
- wp-cli
- yarn
- zip

