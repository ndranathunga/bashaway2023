
# Use the official PHP image with Apache
FROM php:8.0-apache

# Install necessary PHP extensions and tools for Laravel
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip && \
    docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Enable mod_rewrite for Apache (used for pretty URLs)
RUN a2enmod rewrite

# Set the document root to the public directory of our app
ENV APACHE_DOCUMENT_ROOT /var/www/html/public

# Update the default apache site to point to our public directory
RUN sed -ri -e 's!/var/www/html!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/sites-available/*.conf
RUN sed -ri -e 's!/var/www/!${APACHE_DOCUMENT_ROOT}!g' /etc/apache2/apache2.conf /etc/apache2/conf-available/*.conf

# Copy the Laravel project into the container
COPY src/ /var/www/html/

# Set necessary permissions for Laravel
RUN chown -R www-data:www-data /var/www/html/storage
RUN chown -R www-data:www-data /var/www/html/bootstrap/cache

# Expose port 80
EXPOSE 80