# Ansible Tower Dockerfie
FROM centos:7

#CentOS Linux release 7.9.2009 (Core)
RUN cat /etc/redhat-release

RUN mkdir -p /vdb/tower
WORKDIR /vdb/tower

RUN yum -y install epel-release --nogpgcheck
RUN yum -y install ansible vim curl deltarpm wget sudo
RUN yum -y install yum-utils
RUN yum -y install python-devel
RUN yum -y install postgresql
RUN yum -y install httpd
