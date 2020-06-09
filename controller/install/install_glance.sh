openstack user create --domain default --password=glance glance

openstack role add --project service --user glance admin

openstack service create --name glance --description "OpenStack Image" image

openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

yum install -y openstack-glance

cp /etc/glance/glance-api.conf /etc/glance/glance-api.conf.bak
cat /dev/null > /etc/glance/glance-api.conf
cat << EOF >> /etc/glance/glance-api.conf
[DEFAULT]

[cors]

[database]
connection = mysql+pymysql://glance:glance@mysql/glance

[glance_store]
stores = file,http
default_store = file
filesystem_store_datadir = /var/lib/glance/images/

[image_format]

[keystone_authtoken]
www_authenticate_uri  = http://controller:5000
auth_url = http://controller:5000
memcached_servers = memcached:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = glance
password = glance

[matchmaker_redis]

[oslo_concurrency]

[oslo_messaging_amqp]

[oslo_messaging_kafka]

[oslo_messaging_notifications]

[oslo_messaging_rabbit]

[oslo_messaging_zmq]

[oslo_middleware]

[oslo_policy]

[paste_deploy]
flavor = keystone

[profiler]

[store_type_location_strategy]

[task]

[taskflow_executor]
EOF

cp /etc/glance/glance-registry.conf /etc/glance/glance-registry.conf.bak
cat /dev/null > /etc/glance/glance-registry.conf
cat << EOF >> /etc/glance/glance-registry.conf
[DEFAULT]

[database]
connection = mysql+pymysql://glance:glance@mysql/glance

[keystone_authtoken]
www_authenticate_uri = http://controller:5000
auth_url = http://controller:5000
memcached_servers = memcached:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = glance
password = glance

[matchmaker_redis]

[oslo_messaging_amqp]

[oslo_messaging_kafka]

[oslo_messaging_notifications]

[oslo_messaging_rabbit]

[oslo_messaging_zmq]

[oslo_policy]

[paste_deploy]
flavor = keystone

[profiler]
EOF
su -s /bin/sh -c "glance-manage db_sync" glance

systemctl start openstack-glance-api.service openstack-glance-registry.service