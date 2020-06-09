cat << EOF >> /etc/yum.repos.d/openstack.repo
[openstack-rocky]
name=openstack-rocky
baseurl=https://mirrors.aliyun.com/centos/7/cloud/x86_64/openstack-train/
enabled=1
gpgcheck=0

[qume-kvm]
name=qemu-kvm
baseurl= https://mirrors.aliyun.com/centos/7/virt/x86_64/kvm-common/
enabled=1
gpgcheck=0
EOF

cat << EOF >> /etc/hosts
192.168.1.103 rabbitmq
192.168.1.103 memcached
192.168.1.101 controller
192.168.1.103 etcd
192.168.1.103 mysql
EOF

systemctl stop firewalld
systemctl disable firewalld
setenforce 0

yum upgrade -y

hostnamectl set-hostname controller

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
sh install_neutron.sh
sh install_dashboard.sh