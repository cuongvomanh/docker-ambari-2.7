FROM centos:7
RUN yum install epel-release -y && yum clean all
RUN yum update -y && yum clean all
RUN yum install -y systemd* && yum clean all

#Setting up systemd
ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN yum install -y yum-utils yum-plugin-ovl tar git curl bind-utils unzip wget && yum clean all
# Setup sshd
RUN yum install -y openssh-server openssh-clients && yum clean all
RUN systemctl enable sshd
# Setup java
ENV JDK_ARTIFACT jdk-8u112-linux-x64.tar.gz
ENV JDK_VERSION jdk1.8.0_112
RUN mkdir /usr/jdk64 && cd /usr/jdk64 && wget http://public-repo-1.hortonworks.com/ARTIFACTS/$JDK_ARTIFACT && \
    tar -xf $JDK_ARTIFACT && rm -f $JDK_ARTIFACT
ENV JAVA_HOME /usr/jdk64/$JDK_VERSION
ENV PATH $PATH:$JAVA_HOME/bin
RUN yum install telnet net-tools -y 
ADD network /etc/sysconfig/network
# initscripts (service wrapper for servicectl) is need othewise the Ambari is unable to start postgresql
RUN yum install -y initscripts && yum clean all

RUN yum install -y ntp && systemctl enable ntpd
