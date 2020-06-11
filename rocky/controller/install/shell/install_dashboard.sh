yum install -y openstack-dashboard

/etc/openstack-dashboard/local_settings

/etc/httpd/conf.d/openstack-dashboard.conf
WSGIApplicationGroup %{GLOBAL}

systemctl restart httpd.service