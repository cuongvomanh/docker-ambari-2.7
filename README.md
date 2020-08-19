# from https://leifengblog.net/blog/install-hortonworks-hdp-3-1-0-on-cluster-of-vmware-virtual-machines/#21--create-and-start-an-http-sever-on-the-master-host
```
docker run -d --privileged --name amb-server -it hortonworks/ambari-base:2.7.3
docker run -d --privileged --name amb1 -it hortonworks/ambari-base:2.7.3
docker run -d --privileged --name amb2 -it hortonworks/ambari-base:2.7.3
docker exec -it amb-server /bin/sh
docker exec -it amb1 /bin/sh
docker exec -it amb2 /bin/sh

docker inspect amb-server | grep IPAdd
<!--docker cp hosts amb-server:/etc/hosts-->
<!--docker cp hosts amb1:/etc/hosts-->
<!--docker cp hosts amb2:/etc/hosts-->
```
#Each
```
passwd
```

#Master
```
ssh-keygen -t rsa
ssh-copy-id localhost
scp -pr /root/.ssh root@amb1.service.consul:/root/
scp -pr /root/.ssh root@amb2.service.consul:/root/
```
## Each
```
systemctl start ntpd
```
#Master
```
service httpd restart
chkconfig httpd on
docker cp ambari-env.sh amb-server:/var/lib/ambari-server/ambari-env.sh
ambari-server setup -j /usr/jdk64/jdk1.8.0_112 -s
ambari-server start
```
