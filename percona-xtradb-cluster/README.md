dockerfiles
===========

Dockerfile to build images

wsrep_notify.sh is from http://fossies.org/linux/misc/mariadb-galera-5.5.29.tar.gz:t/mariadb-5.5.29/support-files/wsrep_notify.sh

To start a new cluster: /usr/bin/mysqld_safe --wsrep-new-cluster

To join a running cluster: /usr/bin/mysqld_safe --wsrep_cluster_address=gcomm://ip.addres.node.1

# Create a 3 node cluster
NODE1=$(docker run -d percona-xtradb-cluster --wsrep-new-cluster)
NODE1_IP=$(sudo docker inspect $NODE1 | grep IPAddress | awk '{ print $2 }' | tr -d ',"')
NODE2=$(docker run -d percona-xtradb-cluster --wsrep_cluster_address=gcomm://$NODE1_IP)
NODE2_IP=$(sudo docker inspect $NODE2 | grep IPAddress | awk '{ print $2 }' | tr -d ',"')
