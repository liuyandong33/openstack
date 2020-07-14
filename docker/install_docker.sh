yum remove docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine

yum install -y yum-utils device-mapper-persistent-data lvm2

yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce docker-ce-cli containerd.io

systemctl start docker

systemctl enable docker

https://github.com/docker/compose/releases/

下载docker-compose 放到/usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version