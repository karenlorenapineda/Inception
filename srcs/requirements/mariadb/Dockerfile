# Usamos Debian Bookworm como base universal para el proyecto
FROM debian:bookworm

# Actualizamos e instalamos el servidor de MariaDB
RUN apt update && apt upgrade -y && apt install -y mariadb-server

# Creamos el directorio de ejecución seguro para el socket de MariaDB y le damos permisos
RUN mkdir -p /var/run/mysqld && chown -R mysql:mysql /var/run/mysqld && chmod 777 /var/run/mysqld

# Copiamos nuestra configuración personalizada de red
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copiamos el script de configuración, le damos permisos de ejecución
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

# Exponemos el puerto estándar de bases de datos MySQL/MariaDB
EXPOSE 3306

# Definimos el script como el punto de entrada que levantará el servicio
ENTRYPOINT ["/usr/local/bin/setup.sh"]
