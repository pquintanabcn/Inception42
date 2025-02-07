#!/bin/sh

echo "Iniciando MariaDB..."
mariadb-install-db --user=mysql --ldata=/var/lib/mysql
mysqld_safe --datadir='/var/lib/mysql' &

# Wait to iniciate
sleep 5

# maybe change something
mysql -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
mysql -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
mysql -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';"
mysql -e "FLUSH PRIVILEGES;"

# Apagar el servicio para que pueda ser ejecutado por el CMD final
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

# Iniciar MariaDB en primer plano
exec mysqld_safe --datadir='/var/lib/mysql'


#echo "Waiting for MariaDB to start..."
#until mysqladmin ping --silent; do
#    sleep 1
#done

# Crear base de datos si no existe
#if ! mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "USE ${MYSQL_DATABASE}"; then
#    echo "Creating database ${MYSQL_DATABASE}..."
#    mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE ${MYSQL_DATABASE};"
#fi

# Crear usuario y asignar privilegios
#echo "Creating user ${MYSQL_USER}..."
#mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
#mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

# Asegurarse de que el usuario root tenga la contraseña configurada
#echo "Setting root password..."
#mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER '${MYSQL_ROOT_USER}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"

#echo "MariaDB setup complete."

