# docker-ambari
from https://leifengblog.net/blog/install-hortonworks-hdp-3-1-0-on-cluster-of-vmware-virtual-machines/#21--create-and-start-an-http-sever-on-the-master-host

# Build image

```
cd ambari-base && docker build -t hortonworks/ambari-base:2.7.3 ./ && cd .. 
cd ambari-server && docker build -t hortonworks/ambari-server:2.7.3 ./ && cd .. 
cd ambari-base-local && docker build -t hortonworks/ambari-base-local:2.7.3 ./ && cd .. 
cd ambari-server-local && docker build -t hortonworks/ambari-server-local:2.7.3 ./ && cd .. 
```
# Start container
```
docker run -d --privileged --name amb-server -it hortonworks/ambari-server-local:2.7.3
docker run -d --privileged --name amb1 -it hortonworks/ambari-base-local:2.7.3
docker run -d --privileged --name amb2 -it hortonworks/ambari-base-local:2.7.3


docker network create -d bridge amb-net
docker run -d --privileged -p 22 --rm --network amb-net --name amb-server -it hortonworks/ambari-server-local:2.7.3
docker run -d --privileged -p 22 --rm --network amb-net --name amb1 -it hortonworks/ambari-base-local:2.7.3
docker run -d --privileged -p 22 --rm --network amb-net --name amb2 -it hortonworks/ambari-base-local:2.7.3
```
```
docker network create -d bridge test
docker run -d --privileged -p 22 --rm -ti --name u1 --network test hortonworks/ambari-server-local:2.7.3 
docker run -d --privileged -p 22 --rm -ti --name u2 --network test hortonworks/ambari-server-local:2.7.3
```
# Option
```docker exec -it amb-server /bin/sh
docker exec -it amb1 /bin/sh
docker exec -it amb2 /bin/sh

docker inspect amb-server | grep IPAdd
```
# Copy env
```
#docker cp ambari-base/bash_aliases amb-server:/root/.bash_aliases
#docker cp ambari-base/bash_aliases amb1:/root/.bash_aliases
#docker cp ambari-base/bash_aliases amb2:/root/.bash_aliases
#docker cp ambari-base/bash_profile amb-server:/root/.bash_profile
#docker cp ambari-base/bash_profile amb1:/root/.bash_profile
#docker cp ambari-base/bash_profile amb2:/root/.bash_profile

docker exec -it 
docker cp ambari-base/ssh amb-server:/root/.ssh
docker cp ambari-base/ssh amb1:/root/.ssh
docker cp ambari-base/ssh amb2:/root/.ssh

docker exec -it amb-server hostname amb-server
docker exec -it amb1 hostname amb1
docker exec -it amb2 hostname amb2

docker cp ambari-base/hosts amb-server:/root/hosts
docker cp ambari-base/hosts amb1:/root/hosts
docker cp ambari-base/hosts amb2:/root/hosts
docker cp ambari-base/change-hosts.sh amb-server:/root/change-hosts.sh
docker cp ambari-base/change-hosts.sh amb1:/root/change-hosts.sh
docker cp ambari-base/change-hosts.sh amb2:/root/change-hosts.sh
docker exec -it amb-server bash /root/change-hosts.sh
docker exec -it amb1 bash /root/change-hosts.sh
docker exec -it amb2 bash /root/change-hosts.sh

docker exec -it amb-server bash /root/start-base.sh
docker exec -it amb1 bash /root/start-base.sh
docker exec -it amb2 bash /root/start-base.sh
docker exec -it amb-server bash /root/start-server.sh
```
# Each
Change /etc/hosts
```
passwd
```

# Master
```
ssh-keygen -t rsa
ssh-copy-id localhost
ssh amb-server
scp -pr /root/.ssh root@amb1.service.consul:/root/
scp -pr /root/.ssh root@amb2.service.consul:/root/
ssh amb1
ssh amb2
```
# Each
```
systemctl start ntpd
```
# Master
```
service httpd restart
chkconfig httpd on
#docker cp ambari-env.sh amb-server:/var/lib/ambari-server/ambari-env.sh
ambari-server setup -j /usr/jdk64/jdk1.8.0_112 -s
#ambari-server setup -j /usr/jdk64/jdk1.8.0_112 --jdbc-db=mysql --jdbc-driver=/root/mysql-connector-java.jar -s
ambari-server start
#docker cp ambari-server/init.sh amb-server:/root/init.sh
#bash /root/init.sh
```
# Agent
```
yum -y install hdp-select
yum -y install hadoop_3_1_4_0_315
yum -y install hadoop_3_1_4_0_315-yarn
```

#

```
amb-server.service.consul
amb1.service.consul
amb2.service.consul

```
# Check
```
curl -X GET --header 'Content-Type: application/json'  'http://172.17.0.2:8080/resources/mysql-connector-java.jar'
curl -X GET --header 'Content-Type: application/json'  'http://172.17.0.2/HDP-UTILS/centos7/1.1.0.22/hdp-utils.repo'
```
# HDF
```
#wget http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.1.0.0/tars/hdf_ambari_mp/hdf-ambari-mpack-3.1.0.0-564.tar.gz
wget http://public-repo-1.hortonworks.com/HDF/centos7/3.x/updates/3.4.1.1/tars/hdf_ambari_mp/hdf-ambari-mpack-3.4.1.1-4.tar.gz
ambari-server install-mpack --mpack=/root/hdf-ambari-mpack-3.1.0.0-564.tar.gz --verbose
```
```
docker exec -it amb-server rm /etc/yum.repos.d/ambari-hdp-1.repo
docker exec -it amb1 rm /etc/yum.repos.d/ambari-hdp-1.repo
docker exec -it amb2 rm /etc/yum.repos.d/ambari-hdp-1.repo
docker exec -it amb-server cp /var/lib/ambari-server/resources/mysql-jdbc-driver.jar /var/lib/ambari-server/resources/mysql-connector-java.jar

```

