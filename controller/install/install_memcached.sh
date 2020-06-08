yum install -y memcached

cp /etc/sysconfig/memcached /etc/sysconfig/memcached.bak

cat /dev/null > /etc/sysconfig/memcached
cat << EOF >> /etc/sysconfig/memcached
PORT="11211"
USER="memcached"
MAXCONN="1024"
CACHESIZE="64"
OPTIONS="-l 127.0.0.1,::1,controller"
EOF

systemctl start memcached.service