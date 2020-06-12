yum install -y rabbitmq-server

systemctl start rabbitmq-server.service

rabbitmqctl add_user openstack openstack
rabbitmqctl set_permissions openstack ".*" ".*" ".*"

