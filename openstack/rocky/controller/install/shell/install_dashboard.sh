yum install -y openstack-dashboard

mv /etc/openstack-dashboard/local_settings /etc/openstack-dashboard/local_settings.bak
cp ../config/local_settings /etc/openstack-dashboard/local_settings

mv /etc/httpd/conf.d/openstack-dashboard.conf /etc/httpd/conf.d/openstack-dashboard.conf.bak
cp ../config/openstack-dashboard.conf /etc/httpd/conf.d/openstack-dashboard.conf

systemctl restart httpd.service