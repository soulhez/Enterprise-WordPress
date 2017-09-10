FROM php:7.0-apache

# Install Additional Packages
RUN apt-get update \
    && apt-get install -y \
        libpng12-dev \
        libjpeg-dev  \
        curl \
        sed \
        zlib1g-dev \
    && docker-php-ext-install \
        zip \
        mysqli


# Install NodeJS
RUN curl -sL https://deb.nodesource.com/setup_6.x | /bin/bash && \
    apt-get install -y nodejs

# Install Yarn
RUN npm install -g yarn

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Update the default web root
RUN sed -i 's!/var/www/html!/var/www/html/web!g' /etc/apache2/sites-available/000-default.conf

# Move the project to "web root"
COPY . /var/www/html

# Create cache dir and set permissions
RUN mkdir /var/www/html/web/app/uploads/cache && \
    chmod 755 /var/www/html/web/app/uploads/cache

# RUN Composer install on bedrock
RUN cd /var/www/html && composer install

# Set WORKDIR to location of theme
WORKDIR /var/www/html/web/app/themes/example-theme

# Install and compile theme files
RUN composer install
RUN npm install
RUN yarn run build:production

