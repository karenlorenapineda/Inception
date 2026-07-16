# Usamos debian bookworm como base
FROM debian:bookworm

# Actualizamos repositorios e instalamos dependencias necesarias
RUN apt update && apt upgrade -y && apt install -y \
    php8.2 \
    php8.2-fpm \
    php8.2-mysql \
    mariadb-client \
    curl \
    sendmail \
    && rm -rf /var/lib/apt/lists/*

# Configuramos PHP-FPM para que escuche en el puerto 9000
# (necesario para la comunicación con Nginx)
RUN sed -i 's/listen = \/run\/php\/php8.2-fpm.sock/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf

# Creamos los directorios necesarios
RUN mkdir -p /var/www/wordpress
RUN mkdir -p /run/php

# Copiamos nuestro script de configuración
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Exponemos el puerto 9000
EXPOSE 9000

# El script de setup será el encargado de configurar WP e iniciar php-fpm
ENTRYPOINT ["/usr/local/bin/setup.sh"]
