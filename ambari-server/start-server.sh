ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P ""
sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" localhost
sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" amb-server
sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" amb1
sshpass -p '123456a@' ssh-copy-id -o "StrictHostKeyChecking no" amb2
service httpd restart
chkconfig httpd on
ambari-server setup -j /usr/jdk64/jdk1.8.0_112 -s
ambari-server start
