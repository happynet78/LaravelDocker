FROM php:8.3-apache
WORKDIR /var/www/html

# Mod Rewrite
RUN a2enmod rewrite

# Linux Libraries
RUN apt-get update && apt-get install -y libicu-dev libmariadb-dev unzip zip zlib1g-dev libpng-dev libjpeg-dev libfreetype6-dev libzip-dev libfreetype6-dev libonig-dev libxml2-dev libxslt-dev libwebp-dev libjpeg62-turbo

# Composer 
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# PHP Extensions
RUN docker-php-ext-install gettext intl pdo_mysql gd

# RUN docker-php-ext-configure gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) bcmath curl fileinfo filter gd hash iconv mbstring openssl pcre pdo pdo_mysql simplexml sockets sodium tokenizer xmlwriter xsl zip zlib sqlite3 pdo_sqlite && docker-php-ext-enable mysqli zlib pdo_sqlite xsl soap sockets
RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg && docker-php-ext-install -j$(nproc) gd