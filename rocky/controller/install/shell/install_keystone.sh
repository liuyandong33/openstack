yum install -y openstack-keystone httpd mod_wsgi

mv /etc/keystone/keystone.conf /etc/keystone/keystone.conf.bak
cp ../config/keystone.conf /etc/keystone/keystone.conf

su -s /bin/sh -c "keystone-manage db_sync" keystone


keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password admin --bootstrap-admin-url http://controller:5000/v3/ --bootstrap-internal-url http://controller:5000/v3/ --bootstrap-public-url http://controller:5000/v3/ --bootstrap-region-id RegionOne

mv /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
cp ../config/httpd.conf /etc/httpd/conf/httpd.conf

ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/

systemctl start httpd.service

mkdir -p /usr/local/openstack
cat << EOF >> /usr/local/openstack/admin-openrc
export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
EOF

source /usr/local/openstack/admin-openrc
openstack project create --domain default --description "Service Project" service