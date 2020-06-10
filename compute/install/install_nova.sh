yum install -y openstack-nova-compute

cp /etc/nova/nova.conf /etc/nova/nova.conf.bak
cat /dev/null > /etc/nova/nova.conf
cat << EOF >> /etc/nova/nova.conf
[DEFAULT]
enabled_apis = osapi_compute,metadata
transport_url = rabbit://openstack:openstack@rabbitmq:5672/
my_ip = MANAGEMENT_INTERFACE_IP_ADDRESS

[api]
auth_strategy = keystone

[api_database]

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
discover_hosts_in_cells_interval = 300

[serial_console]

[service_user]

[spice]

[upgrade_levels]

[vault]

[vendordata_dynamic_auth]

[vmware]

[vnc]
enabled = true
server_listen = 0.0.0.0
server_proxyclient_address = $my_ip
novncproxy_base_url = http://controller:6080/vnc_auto.html

[workarounds]

[wsgi]

[xenserver]

[xvp]

[zvm]
EOF

systemctl start libvirtd.service openstack-nova-compute.service

su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova
