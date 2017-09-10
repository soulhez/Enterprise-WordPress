FROM php:7.0-apache

# Install Additional Packages
RUN apt-get update \
    && apt-get install -y \
        libpng12-dev \
        libjpeg-dev  \
        sed \
        curl \
        zlib1g-dev \
        nodejs \
        npm \
    && docker-php-ext-install \
        zip \
        mysqli \
    && npm install -g yarnpkg

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Update the default web root
RUN sed -i 's!/var/www/html!/var/www/html/web!g' /etc/apache2/sites-available/000-default.conf


COPY . /var/www/html

RUN cd /var/www/html && composer install

WORKDIR /var/www/html/web/app/themes/example-theme

RUN composer install

# RUN npm install

# RUN yarn run build:production