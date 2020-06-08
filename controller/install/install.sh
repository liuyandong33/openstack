cat << EOF >> /etc/yum.repos.d/openstack.repo
[openstack-rocky]
name=openstack-rocky
baseurl=https://mirrors.aliyun.com/centos/7/cloud/x86_64/openstack-rocky/
enabled=1
gpgcheck=0

[qume-kvm]
name=qemu-kvm
baseurl= https://mirrors.aliyun.com/centos/7/virt/x86_64/kvm-common/
enabled=1
gpgcheck=0
EOF

yum install -y python-openstackclient

yum install -y openstack-selinux

source ../admin-openrc.sh

sh install_rabbitmq.sh
sh install_memcached.sh
sh install_etcd.sh
sh install_keystone.sh
sh install_glance.sh
sh install_placement.sh
sh install_nova.sh