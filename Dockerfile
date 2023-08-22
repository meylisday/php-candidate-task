FROM php:8.2-rc-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    default-mysql-client

RUN docker-php-ext-install pdo_mysql

WORKDIR /var/www/

COPY . /var/www/