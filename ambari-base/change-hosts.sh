cp /etc/hosts ~/hosts.new
sed -i 's/172.17.0.*//' ~/hosts.new
cp -f ~/hosts.new /etc/hosts
cat /root/hosts >> /etc/hosts
