openstack user create --domain default --password=neutron neutron

openstack role add --project service --user neutron admin

openstack service create --name neutron --description "OpenStack Networking" network

openstack endpoint create --region RegionOne network public http://controller:9696
openstack endpoint create --region RegionOne network internal http://controller:9696
openstack endpoint create --region RegionOne network admin http://controller:9696

yum install -y openstack-neutron openstack-neutron-ml2 openstack-neutron-linuxbridge ebtables

mv /etc/neutron/neutron.conf /etc/neutron/neutron.conf.bak
cp ../config/neutron.conf /etc/neutron/neutron.conf

mv /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini.bak
cp ../config/ml2_conf.ini /etc/neutron/plugins/ml2/ml2_conf.ini

mv /etc/neutron/plugins/ml2/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini
cp ../conf/linuxbridge_agent.ini /etc/neutron/plugins/ml2/linuxbridge_agent.ini

mv /etc/neutron/dhcp_agent.ini /etc/neutron/dhcp_agent.ini.bak
cp ../config/dhcp_agent.ini /etc/neutron/dhcp_agent.ini

mv /etc/neutron/metadata_agent.ini /etc/neutron/metadata_agent.ini
cp ../config/metadata_agent.ini /etc/neutron/metadata_agent.ini

ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini

su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

systemctl start neutron-server.service neutron-linuxbridge-agent.service neutron-dhcp-agent.service neutron-metadata-agent.service