yum install -y openstack-neutron-linuxbridge ebtables ipset

mv /etc/neutron/neutron.conf /etc/neutron/neutron.conf.bak
cp ../config/neutron.conf /etc/neutron/neutron.conf

mv /etc/neutron/plugins/ml2/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini.bak
cp ../config/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini


systemctl restart openstack-nova-compute.service
systemctl start neutron-linuxbridge-agent.service