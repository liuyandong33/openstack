openstack user create --domain default --password=nova nova

openstack role add --project service --user nova admin

openstack service create --name nova --description "OpenStack Compute" compute

openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1

openstack user create --domain default --password=placement placement

openstack role add --project service --user placement admin

openstack service create --name placement --description "Placement API" placement

openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

yum install -y openstack-nova-api openstack-nova-conductor openstack-nova-console openstack-nova-novncproxy openstack-nova-scheduler openstack-nova-placement-api

mv /etc/nova/nova.conf /etc/nova/nova.conf.bak
cp ../config/nova.conf /etc/nova/nova.conf

mv /etc/httpd/conf.d/00-nova-placement-api.conf /etc/httpd/conf.d/00-nova-placement-api.conf.bak
cp ../config/00-nova-placement-api.conf /etc/httpd/conf.d/00-nova-placement-api.conf

systemctl restart httpd

su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
su -s /bin/sh -c "nova-manage db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 list_cells" nova

systemctl start openstack-nova-api.service openstack-nova-consoleauth openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service