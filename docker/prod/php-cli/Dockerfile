FROM php:7.2-cli

#RUN apt-get update && apt-get install -y unzip
    #&& docker-php-ext-install opcache

#COPY ./docker/prod/php-cli/default.ini /usr/local/etc/php/conf.d/default.ini

#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer --quiet

#ENV COMPOSER_ALLOW_SUPERUSER 1

WORKDIR /app

#COPY ./composer.json ./

#RUN composer install --no-dev --prefer-dist --optimize-autoloader

COPY ./ ./
