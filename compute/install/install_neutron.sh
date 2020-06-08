yum install openstack-neutron-linuxbridge ebtables ipset

cp /etc/neutron/neutron.conf /etc/neutron/neutron.conf.bak
cat /dev/null > /etc/neutron/neutron.conf
cat << EOF >> /etc/neutron/neutron.conf
[DEFAULT]
transport_url = rabbit://openstack:openstack@rabbitmq
auth_strategy = keystone

[cors]

[database]

[keystone_authtoken]
www_authenticate_uri = http://controller:5000
auth_url = http://controller:5000
memcached_servers = memcached:11211
auth_type = password
project_domain_name = default
user_domain_name = default
project_name = service
username = neutron
password = neutron

[oslo_concurrency]
lock_path = /var/lib/neutron/tmp

[oslo_messaging_amqp]

[oslo_messaging_kafka]

[oslo_messaging_notifications]

[oslo_messaging_rabbit]

[oslo_middleware]

[oslo_policy]

[privsep]

[ssl]
EOF


cp /etc/neutron/plugins/ml2/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini.bak
cat /dev/null > /etc/neutron/plugins/ml2/linuxbridge_agent.ini
cat << EOF >> /etc/neutron/plugins/ml2/linuxbridge_agent.ini
[linux_bridge]
physical_interface_mappings = provider:eth1

[vxlan]
enable_vxlan = false

[securitygroup]
enable_security_group = true
firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver
EOF

systemctl start neutron-linuxbridge-agent.service