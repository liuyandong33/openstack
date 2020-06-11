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
172.16.102.75 rabbitmq
172.16.102.75 memcached
172.16.102.77 compute
172.16.102.75 etcd
172.16.102.75 mysql
EOF

systemctl stop firewalld
systemctl disable firewalld
setenforce 0