yum install -y openstack-nova-compute

mv /etc/nova/nova.conf /etc/nova/nova.conf.bak
cp ../config/nova.conf /etc/nova/nova.conf

systemctl start libvirtd.service openstack-nova-compute.service