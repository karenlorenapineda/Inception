#!/bin/sh
echo "--- EL SCRIPT DE CONFIGURACION HA EMPEZADO ---"

# Leer contraseñas
if [ -f "/run/secrets/db_password" ]; then
    MYSQL_PASSWORD=$(cat /run/secrets/db_password)
fi
if [ -f "/run/secrets/db_root_password" ]; then
    MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
fi

# ELIMINAMOS EL IF PARA QUE SE EJECUTE CADA VEZ
# Solo inicializamos si realmente no hay datos
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Arrancar temporal
mysqld_safe --datadir='/var/lib/mysql' &
sleep 5

# CONFIGURAR SIEMPRE
mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
mysql -u root -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Apagar temporal
mysqladmin -u root shutdown
sleep 2

echo "--- CONFIGURACION FINALIZADA ---"
exec mysqld_safe --datadir='/var/lib/mysql'
