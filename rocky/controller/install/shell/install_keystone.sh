yum install -y openstack-keystone httpd mod_wsgi

/etc/keystone/keystone.conf

[database]
connection = mysql+pymysql://keystone:keystone@mysql/keystone

[token]
provider = fernet

su -s /bin/sh -c "keystone-manage db_sync" keystone


keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password admin --bootstrap-admin-url http://controller:5000/v3/ --bootstrap-internal-url http://controller:5000/v3/ --bootstrap-public-url http://controller:5000/v3/ --bootstrap-region-id RegionOne

/etc/httpd/conf/httpd.conf
ServerName controller


ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/


export OS_USERNAME=admin
export OS_PASSWORD=admin
export OS_PROJECT_NAME=admin
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3

openstack project create --domain default --description "Service Project" service