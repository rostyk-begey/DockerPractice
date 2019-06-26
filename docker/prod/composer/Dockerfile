FROM composer:latest

WORKDIR /app

COPY --from=composer ./ ./

RUN composer install --no-dev --prefer-dist --optimize-autoloader