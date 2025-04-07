FROM php:8.2-fpm

WORKDIR /var/www

# Устанавливаем необходимые зависимости, включая cron
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    curl \
    git \
    cron \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Устанавливаем Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Копируем файл crontab в контейнер
COPY ./docker/php/crontab /etc/cron.d/laravel-cron

# Делаем файл crontab исполняемым
RUN chmod 0644 /etc/cron.d/laravel-cron

# Добавляем cron в автозагрузку
RUN crontab /etc/cron.d/laravel-cron

# Указываем запуск cron вместе с PHP-FPM
CMD ["sh", "-c", "cron && php-fpm"]
