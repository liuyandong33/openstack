openstack user create --domain default --password=swift swift

openstack role add --project service --user swift admin

openstack service create --name swift --description "OpenStack Object Storage" object-store

openstack endpoint create --region RegionOne object-store public http://controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region RegionOne object-store internal http://controller:8080/v1/AUTH_%\(project_id\)s
openstack endpoint create --region RegionOne object-store admin http://controller:8080/v1

yum install -y openstack-swift-proxy python-swiftclient python-keystoneclient python-keystonemiddleware

curl -o /etc/swift/proxy-server.conf https://opendev.org/openstack/swift/raw/branch/master/etc/proxy-server.conf-sample

cp /etc/swift/proxy-server.conf /etc/swift/proxy-server.conf.bak
cat /dev/null > /etc/swift/proxy-server.conf
cat << EOF >> /etc/swift/proxy-server.conf
[DEFAULT]
bind_port = 8080
user = swift
swift_dir = /etc/swift

[pipeline:main]
bind_port = 8080
pipeline = catch_errors gatekeeper healthcheck proxy-logging cache listing_formats container_sync bulk tempurl ratelimit tempauth copy container-quotas account-quotas slo dlo versioned_writes symlink proxy-logging proxy-server

[app:proxy-server]
bind_port = 8080
use = egg:swift#proxy
account_autocreate = True

[filter:tempauth]
bind_port = 8080
use = egg:swift#tempauth
user_admin_admin = admin .admin .reseller_admin
user_test_tester = testing .admin
user_test_tester2 = testing2 .admin
user_test_tester3 = testing3
user_test2_tester2 = testing2 .admin
user_test5_tester5 = testing5 service

[filter:s3api]
bind_port = 8080
use = egg:swift#s3api

[filter:s3token]
bind_port = 8080
use = egg:swift#s3token
reseller_prefix = AUTH_
delay_auth_decision = False
auth_uri = http://controller:5000/v3
http_timeout = 10.0

[filter:healthcheck]
bind_port = 8080
use = egg:swift#healthcheck

[filter:cache]
bind_port = 8080
use = egg:swift#memcache
memcached_servers = memcached:11211

[filter:ratelimit]
bind_port = 8080
use = egg:swift#ratelimit

[filter:read_only]
bind_port = 8080
use = egg:swift#read_only

[filter:domain_remap]
bind_port = 8080
use = egg:swift#domain_remap

[filter:catch_errors]
bind_port = 8080
use = egg:swift#catch_errors

[filter:cname_lookup]
bind_port = 8080
use = egg:swift#cname_lookup

[filter:staticweb]
bind_port = 8080
use = egg:swift#staticweb

[filter:tempurl]
bind_port = 8080
use = egg:swift#tempurl

[filter:formpost]
bind_port = 8080
use = egg:swift#formpost

[filter:name_check]
bind_port = 8080
use = egg:swift#name_check

[filter:etag-quoter]
bind_port = 8080
use = egg:swift#etag_quoter

[filter:list-endpoints]
bind_port = 8080
use = egg:swift#list_endpoints

[filter:proxy-logging]
bind_port = 8080
use = egg:swift#proxy_logging

[filter:bulk]
bind_port = 8080
use = egg:swift#bulk

[filter:slo]
bind_port = 8080
use = egg:swift#slo

[filter:dlo]
bind_port = 8080
use = egg:swift#dlo

[filter:container-quotas]
bind_port = 8080
use = egg:swift#container_quotas

[filter:account-quotas]
bind_port = 8080
use = egg:swift#account_quotas

[filter:gatekeeper]
bind_port = 8080
use = egg:swift#gatekeeper

[filter:container_sync]
bind_port = 8080
use = egg:swift#container_sync

[filter:xprofile]
bind_port = 8080
use = egg:swift#xprofile

[filter:versioned_writes]
bind_port = 8080
use = egg:swift#versioned_writes

[filter:copy]
bind_port = 8080
use = egg:swift#copy

[filter:keymaster]
bind_port = 8080
use = egg:swift#keymaster
encryption_root_secret = changeme

[filter:kms_keymaster]
bind_port = 8080
use = egg:swift#kms_keymaster

[filter:kmip_keymaster]
bind_port = 8080
use = egg:swift#kmip_keymaster

[filter:encryption]
bind_port = 8080
use = egg:swift#encryption

[filter:listing_formats]
bind_port = 8080
use = egg:swift#listing_formats

[filter:symlink]
bind_port = 8080
use = egg:swift#symlink

[filter:keystoneauth]
use = egg:swift#keystoneauth
operator_roles = admin,user

[filter:authtoken]
paste.filter_factory = keystonemiddleware.auth_token:filter_factory
www_authenticate_uri = http://controller:5000
auth_url = http://controller:5000
memcached_servers = memcached:11211
auth_type = password
project_domain_id = default
user_domain_id = default
project_name = service
username = swift
password = swift
delay_auth_decision = True
EOF