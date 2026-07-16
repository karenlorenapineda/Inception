#!/bin/sh

# Activar modo de depuración para ver los comandos en 'docker-compose logs'
set -x

# 1. Leer contraseña desde Docker Secrets si el archivo existe
if [ -f "/run/secrets/db_password" ]; then
    export MYSQL_PASSWORD=$(cat /run/secrets/db_password)
fi

# 2. Asegurar que MariaDB esté lista (tiempo de gracia)
sleep 10

# 3. Comprobar si WordPress ya está instalado
if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    
    mkdir -p /var/www/wordpress
    cd /var/www/wordpress
    
    # Descargar WP-CLI si no existe
    if [ ! -f "/usr/local/bin/wp" ]; then
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        chmod +x wp-cli.phar
        mv wp-cli.phar /usr/local/bin/wp
    fi
    
    # Descargar archivos de WordPress
    wp core download --allow-root
    
    # Crear wp-config.php
    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${MYSQL_PASSWORD}" \
        --dbhost=mariadb \
        --allow-root
    
    # Instalar WordPress
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="${WP_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    # Crear usuario autor obligatorio
    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_PASSWORD}" \
        --role=author \
        --allow-root
fi

# Ajustar permisos para el servidor web (importante para que PHP-FPM funcione)
chown -R www-data:www-data /var/www/wordpress

# Crear directorio de logs de PHP si no existe
mkdir -p /run/php

# Arrancar PHP-FPM en primer plano
exec /usr/sbin/php-fpm8.2 -F
