FROM hortonworks/ambari-base:2.7.3
RUN mkdir /etc/yum.repos.d/backup_repo && mv /etc/yum.repos.d/*.repo /etc/yum.repos.d/backup_repo
ADD local.repo /etc/yum.repos.d/ambari.repo 
ADD local.repo /etc/yum.repos.d/ambari-hdp.repo 
RUN yum clean all
