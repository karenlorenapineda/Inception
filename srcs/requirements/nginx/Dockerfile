# Usamos Debian Bookworm como base (estable y segura)
FROM debian:bookworm

# Actualizamos el sistema e instalamos Nginx y OpenSSL
RUN apt update && apt upgrade -y && apt install -y nginx openssl

# Creamos la carpeta para los certificados SSL
RUN mkdir -p /etc/nginx/ssl

# Generamos el certificado SSL autofirmado exigido por el subject
# Usamos tu login kpineda-.42.fr como el Common Name (CN)
RUN openssl req -x509 -nodes -days 365 -newkey rsa:4045 \
    -keyout /etc/nginx/ssl/inception.key \
    -out /etc/nginx/ssl/inception.crt \
    -subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=42Madrid/CN=kpineda-.42.fr"

# Copiamos nuestro archivo de configuración personalizado dentro del contenedor
COPY conf/nginx.conf /etc/nginx/sites-available/default

# Aseguramos que Nginx tenga permisos sobre la web
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# Exponemos el puerto 443 de cara al exterior (único permitido para Nginx)
EXPOSE 443

# Arrancamos Nginx en primer plano para que el contenedor no se apague
CMD ["nginx", "-g", "daemon off;"]
