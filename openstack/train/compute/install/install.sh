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

cat << EOF >> /etc/hosts
127.0.0.1 rabbitmq
127.0.0.1 memcached
127.0.0.1 controller
EOF

# 安装 nova 服务
sh install_nova.sh

# 安装 neutron 服务
sh install_neutron.sh