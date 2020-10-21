docker run -d --privileged --name amb-server -it hortonworks/ambari-server-local:2.7.3
docker run -d --privileged --name amb1 -it hortonworks/ambari-base-local:2.7.3
docker run -d --privileged --name amb2 -it hortonworks/ambari-base-local:2.7.3

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

