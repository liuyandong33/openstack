openstack user create --domain default --password=placement placement

openstack role add --project service --user placement admin

openstack service create --name placement --description "Placement API" placement

openstack endpoint create --region RegionOne placement public http://controller:8778
openstack endpoint create --region RegionOne placement internal http://controller:8778
openstack endpoint create --region RegionOne placement admin http://controller:8778

yum install -y openstack-placement-api
su -s /bin/sh -c "placement-manage db sync" placement

mv /etc/placement/placement.conf /etc/placement/placement.conf.bak
cp ../config/placement.conf /etc/placement/placement.conf

su -s /bin/sh -c "placement-manage db sync" placement
systemctl restart httpd