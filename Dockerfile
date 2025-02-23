FROM php:8.2-apache

# Установка необходимых расширений PHP
RUN docker-php-ext-install pdo_mysql mysqli

# Включение модуля Apache rewrite (опционально)
RUN a2enmod rewrite

# Копирование файлов проекта в контейнер
COPY ./src /var/www/html

# Установка прав на папку (опционально)
RUN chown -R www-data:www-data /var/www/html