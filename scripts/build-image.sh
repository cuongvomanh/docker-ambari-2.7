cd ambari-base && docker build -t hortonworks/ambari-base:2.7.3 ./ && cd ..  
cd ambari-server && docker build -t hortonworks/ambari-server:2.7.3 ./ && cd ..
cd ambari-base-local && docker build -t hortonworks/ambari-base-local:2.7.3 ./ && cd ..
cd ambari-server-local && docker build -t hortonworks/ambari-server-local:2.7.3 ./ && cd ..


