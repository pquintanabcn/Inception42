#!/bin/sh

echo "Iniciando MariaDB..."
mariadb-install-db --user=mysql --ldata=/var/lib/mysql


# Wait to iniciate
mysqld_safe --datadir='/var/lib/mysql' &
sleep 10

while ! mariadb -u root -e "SELECT 1" >/dev/null 2>&1; do
	echo "Waiting for Mariadb to be ready..."
	sleep 2
done

echo "MariaDB ready, executing initial conf..."

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
