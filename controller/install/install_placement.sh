openstack user create --domain default --password=placement placement

openstack role add --project service --user placement admin

openstack service create --name placement --description "Placement API" placement

openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

yum install -y openstack-placement-api
su -s /bin/sh -c "placement-manage db sync" placement

cp /etc/placement/placement.conf /etc/placement/placement.conf.bak
cat /dev/null > /etc/placement/placement.conf
cat << EOF >> /etc/nova/nova.conf
[DEFAULT]

[api]
auth_strategy = keystone

[cors]

[keystone_authtoken]
auth_url = http://controller:5000/v3
memcached_servers = memcached:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = placement
password = placement

[oslo_policy]

[placement]

[placement_database]
connection = mysql+pymysql://placement:placement@mysql/placement

[profiler]
EOF

systemctl restart httpd