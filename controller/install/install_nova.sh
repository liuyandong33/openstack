openstack user create --domain default --password=nova nova

openstack role add --project service --user nova admin

openstack service create --name nova --description "OpenStack Compute" compute

openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1

yum install -y openstack-nova-api openstack-nova-conductor openstack-nova-novncproxy openstack-nova-scheduler

cp /etc/nova/nova.conf /etc/nova/nova.conf.bak
cat /dev/null > /etc/nova/nova.conf
cat << EOF >> /etc/nova/nova.conf
[DEFAULT]
enabled_apis = osapi_compute,metadata
my_ip = 192.168.1.101

[api]
auth_strategy = keystone

[api_database]
connection = mysql+pymysql://nova:nova@mysql/nova_api
transport_url = rabbit://openstack:openstack@rabbitmq:5672/

[barbican]

[cache]

[cells]

[cinder]

[compute]

[conductor]

[console]

[consoleauth]

[cors]

[database]
connection = mysql+pymysql://nova:nova@mysql/nova

[devices]

[ephemeral_storage_encryption]

[filter_scheduler]

[glance]
api_servers = http://controller:9292

[guestfs]

[healthcheck]

[hyperv]

[ironic]

[key_manager]

[keystone]

[keystone_authtoken]
www_authenticate_uri = http://controller:5000/
auth_url = http://controller:5000/
memcached_servers = memcached:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = nova
password = nova

[libvirt]

[matchmaker_redis]

[metrics]

[mks]

[neutron]
auth_url = http://controller:5000
auth_type = password
project_domain_name = default
user_domain_name = default
region_name = RegionOne
project_name = service
username = neutron
password = neutron
service_metadata_proxy = true
metadata_proxy_shared_secret = METADATA_SECRET

[notifications]

[osapi_v21]

[oslo_concurrency]
lock_path = /var/lib/nova/tmp

[oslo_messaging_amqp]

[oslo_messaging_kafka]

[oslo_messaging_notifications]

[oslo_messaging_rabbit]

[oslo_messaging_zmq]

[oslo_middleware]

[oslo_policy]

[pci]

[placement]
region_name = RegionOne
project_domain_name = Default
project_name = service
auth_type = password
user_domain_name = Default
auth_url = http://controller:5000/v3
username = placement
password = placement

[placement_database]

[powervm]

[profiler]

[quota]

[rdp]

[remote_debug]

[scheduler]

[serial_console]

[service_user]

[spice]

[upgrade_levels]

[vault]

[vendordata_dynamic_auth]

[vmware]

[vnc]
enabled = true
server_listen = $my_ip
server_proxyclient_address = $my_ip

[workarounds]

[wsgi]

[xenserver]

[xvp]

[zvm]
EOF

su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
su -s /bin/sh -c "nova-manage db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 list_cells" nova

systemctl start openstack-nova-api.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service