# Percona XtraDB Cluster Server

# VERSION	1

## CENTOS
# use CentOS base by dotCloud
FROM centos

MAINTAINER Adrian Lopez, adrianlzt@gmail.com

# Clean metadata to force to read the repositories
RUN yum clean metadata
# Updating to get the last CentOS packages
RUN yum -y update

## EPEL
# EPEL is needed for the socat package
RUN rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm

## PERCONA
# Percona packages packed by Percona itself
RUN rpm -Uhv http://www.percona.com/downloads/percona-release/percona-release-0.0-1.x86_64.rpm

# Percona cluster server and xtrabackup to make the state transfers. which is required by xtrabackup
RUN yum -y install Percona-XtraDB-Cluster-server Percona-XtraDB-Cluster-client Percona-Server-shared-compat percona-xtrabackup which

# Delete anonymous user, delete test database, allow root login from anywhere and set root password to 'docker'
ADD mysql_safe_install.sh /tmp/mysql_safe_install.sh
RUN /tmp/mysql_safe_install.sh

# Configure Pecona Server
# Use docker insert to change the configuration file
ADD my.cnf /etc/my.cnf
RUN chmod 0640 /etc/my.cnf
RUN chown root:root /etc/my.cnf

# Example wsrep_notify.sh
ADD wsrep_notify.sh /usr/local/bin/wsrep_notify.sh
RUN chmod 0755 /usr/local/bin/wsrep_notify.sh
RUN chown root:root /usr/local/bin/wsrep_notify.sh

# Expose MySQL port
EXPOSE 3306

# Percona server binary
ENTRYPOINT ["/usr/bin/mysqld_safe"]

# Show help if no parameter is passed
CMD ["--help"]
