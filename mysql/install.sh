yum install libaio -y

rm -rf /usr/local/mysql
rm -rf /mydata
rm -rf /etc/my.cnf

groupadd -r mysql
useradd -r -g mysql -s /sbin/nologin mysql
mkdir -p /mydata/data
mkdir -p /mydata/dbdumps
mkdir -p /mydata/logs/error_logs
mkdir -p /mydata/logs/mysql_bin_logs
mkdir -p /mydata/logs/mysql_relay_logs
mkdir -p /mydata/logs/slow_query_logs
mkdir -p /mydata/logs_bak/mysql-bin-log
chown -R mysql:mysql /mydata/logs
chown -R mysql:mysql /mydata/data

tar -xzvf mysql-5.7.21-el7-x86_64.tar.gz -C /usr/local/
mv /usr/local/mysql-5.7.21-el7-x86_64 /usr/local/mysql

cp my.cnf /etc/my.cnf
cp mysqld /etc/init.d/mysqld
chmod 755 /etc/init.d/mysqld

/usr/local/mysql/bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/mydata/data
chkconfig mysqld on
service mysqld restart

/usr/local/mysql/bin/mysql -uroot  <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
CREATE USER 'root'@'%' IDENTIFIED BY 'root';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF

rm -rf /mysql

systemctl stop firewalld
systemctl disable firewalld

172.0.0.2 squid
172.0.0.3 rabbitmq
172.0.0.4 memcached
172.0.0.5 etcd
172.0.0.6 mysql