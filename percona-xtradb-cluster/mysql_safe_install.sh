#!/bin/bash

# Start server with cluster
echo "Starting Percona Server..."
/usr/bin/mysqld_safe --wsrep-new-cluster &

# Wait until the server has started
sleep 5

# Delete anonymous users
# Only allow root access from localhost
# Drop test database
echo "Deleting anonymous users, test table and only allowing access to root from localhost"
/usr/bin/mysql -uroot -e "DELETE FROM mysql.user WHERE User=''; DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); DROP DATABASE IF EXISTS test; FLUSH PRIVILEGES;"

# Permit root access from anywhere (we are outside container)
echo "Allowing root access from anywhere (we are outside the container!)"
/usr/bin/mysql -uroot -e "UPDATE mysql.user SET host='%' WHERE user='root' and host='localhost'; FLUSH PRIVILEGES;"

# Set root password to docker
echo "Setting the root password to docker"
/usr/bin/mysqladmin -u root password "docker"

# Shutdown cluster and server
echo "Shutting down Percona Server"
kill `cat /var/lib/mysql/*.pid`
