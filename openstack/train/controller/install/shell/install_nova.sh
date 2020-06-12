openstack user create --domain default --password=nova nova

openstack role add --project service --user nova admin

openstack service create --name nova --description "OpenStack Compute" compute

openstack endpoint create --region RegionOne compute public http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://controller:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://controller:8774/v2.1

yum install -y openstack-nova-api openstack-nova-conductor openstack-nova-novncproxy openstack-nova-scheduler

mv /etc/nova/nova.conf /etc/nova/nova.conf.bak
cp ../config/nova.conf /etc/nova/nova.conf

su -s /bin/sh -c "nova-manage api_db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 map_cell0" nova
su -s /bin/sh -c "nova-manage cell_v2 create_cell --name=cell1 --verbose" nova
su -s /bin/sh -c "nova-manage db sync" nova
su -s /bin/sh -c "nova-manage cell_v2 list_cells" nova

systemctl start openstack-nova-api.service openstack-nova-scheduler.service openstack-nova-conductor.service openstack-nova-novncproxy.service