openstack user create --domain default --password=glance glance

openstack role add --project service --user glance admin

openstack service create --name glance --description "OpenStack Image" image

openstack endpoint create --region RegionOne image public http://controller:9292
openstack endpoint create --region RegionOne image internal http://controller:9292
openstack endpoint create --region RegionOne image admin http://controller:9292

yum install -y openstack-glance

mv /etc/glance/glance-api.conf /etc/glance/glance-api.conf.bak
cp ../config/glance-api.conf /etc/glance/glance-api.conf

mv /etc/glance/glance-registry.conf /etc/glance/glance-registry.conf.bak
cp ../config/glance-registry.conf /etc/glance/glance-registry.conf

su -s /bin/sh -c "glance-manage db_sync" glance

systemctl start openstack-glance-api.service openstack-glance-registry.service