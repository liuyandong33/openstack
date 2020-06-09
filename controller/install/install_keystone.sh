yum install -y openstack-keystone httpd mod_wsgi

cp /etc/keystone/keystone.conf /etc/keystone/keystone.conf.bak
cat /dev/null > /etc/keystone/keystone.conf
cat << EOF >> /etc/keystone/keystone.conf
[DEFAULT]

[application_credential]

[assignment]

[auth]

[cache]

[catalog]

[cors]

[credential]

[database]
connection = mysql+pymysql://keystone:keystone@mysql/keystone

[domain_config]

[endpoint_filter]

[endpoint_policy]

[eventlet_server]

[federation]

[fernet_tokens]

[healthcheck]

[identity]

[identity_mapping]

[ldap]

[matchmaker_redis]

[memcache]

[oauth1]

[oslo_messaging_amqp]

[oslo_messaging_kafka]

[oslo_messaging_notifications]

[oslo_messaging_rabbit]

[oslo_messaging_zmq]

[oslo_middleware]

[oslo_policy]

[policy]

[profiler]

[resource]

[revoke]

[role]

[saml]

[security_compliance]

[shadow_users]

[signing]

[token]
provider = fernet

[tokenless_auth]

[trust]

[unified_limit]

[wsgi]
EOF

su -s /bin/sh -c "keystone-manage db_sync" keystone

keystone-manage fernet_setup --keystone-user keystone --keystone-group keystone
keystone-manage credential_setup --keystone-user keystone --keystone-group keystone

keystone-manage bootstrap --bootstrap-password admin --bootstrap-admin-url http://controller:5000/v3/ --bootstrap-internal-url http://controller:5000/v3/ --bootstrap-public-url http://controller:5000/v3/ --bootstrap-region-id RegionOne

cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.bak
cat /dev/null > /etc/httpd/conf/httpd.conf
cat << EOF >> /etc/httpd/conf/httpd.conf
ServerRoot "/etc/httpd"

Listen 80

Include conf.modules.d/*.conf

User apache
Group apache

ServerAdmin root@localhost
ServerName controller

<Directory />
AllowOverride none
Require all denied
</Directory>

DocumentRoot "/var/www/html"

<Directory "/var/www">
AllowOverride None
Require all granted
</Directory>

<Directory "/var/www/html">
Options Indexes FollowSymLinks

AllowOverride None

Require all granted
</Directory>

<IfModule dir_module>
DirectoryIndex index.html
</IfModule>

<Files ".ht*">
Require all denied
</Files>

ErrorLog "logs/error_log"

LogLevel warn

<IfModule log_config_module>
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
LogFormat "%h %l %u %t \"%r\" %>s %b" common

<IfModule logio_module>
LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
</IfModule>

CustomLog "logs/access_log" combined
</IfModule>

<IfModule alias_module>

ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"

</IfModule>

<Directory "/var/www/cgi-bin">
AllowOverride None
Options None
Require all granted
</Directory>

<IfModule mime_module>
TypesConfig /etc/mime.types

AddType application/x-compress .Z
AddType application/x-gzip .gz .tgz

AddType text/html .shtml
AddOutputFilter INCLUDES .shtml
</IfModule>

AddDefaultCharset UTF-8

<IfModule mime_magic_module>
MIMEMagicFile conf/magic
</IfModule>

EnableSendfile on

IncludeOptional conf.d/*.conf
EOF

ln -s /usr/share/keystone/wsgi-keystone.conf /etc/httpd/conf.d/

systemctl start httpd.service

openstack project create --domain default --description "Service Project" service