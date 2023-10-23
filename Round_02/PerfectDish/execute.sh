# Start Install Google Chrome (You may comment out these lines during local testing if you already have Chrome installed)

sudo apt update

wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb

sudo apt-get install -f

rm google-chrome-stable_current_amd64.deb

# End Install Google Chrome

# Write your code here

# Define the content of the Dockerfile
dockerfile_content = """
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
"""

# Save the Dockerfile content to a file
dockerfile_path = os.path.join(extraction_dir, "Dockerfile")
with open(dockerfile_path, "w") as dockerfile:
    dockerfile.write(dockerfile_content)

# Define the content of the docker-compose.yml file
docker_compose_content = """
version: '3'

services:
  laravel_app:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: bashaway-2k23-perfect-dish
    ports:
      - "8001:80"
"""

# Save the docker-compose.yml content to a file
docker_compose_path = os.path.join(extraction_dir, "docker-compose.yml")
with open(docker_compose_path, "w") as docker_compose_file:
    docker_compose_file.write(docker_compose_content)


# Build the Docker container
docker-compose build

# Run the Docker container
docker-compose up -d
