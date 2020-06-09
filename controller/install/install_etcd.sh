yum -y install etcd

cp /etc/etcd/etcd.conf /etc/etcd/etcd.conf.bak
cat /dev/null > /etc/etcd/etcd.conf

cat << EOF >> /etc/etcd/etcd.conf
#[Member]
ETCD_DATA_DIR="/var/lib/etcd/default.etcd"
ETCD_LISTEN_PEER_URLS="http://etcd:2380"
ETCD_LISTEN_CLIENT_URLS="http://etcd:2379"
ETCD_NAME="controller"

#[Clustering]
ETCD_INITIAL_ADVERTISE_PEER_URLS="http://etcd:2380"
ETCD_ADVERTISE_CLIENT_URLS="http://etcd:2379"
ETCD_INITIAL_CLUSTER="default=http://etcd:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster-01"
ETCD_INITIAL_CLUSTER_STATE="new"
EOF

systemctl start etcd
