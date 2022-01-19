# Ansible Tower Dockerfie
FROM centos:7

MAINTAINER lucky

#CentOS Linux release 7.9.2009 (Core)
RUN cat /etc/redhat-release

RUN mkdir -p /vdb/tower
WORKDIR /vdb/tower

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN yum -y install epel-release --nogpgcheck
RUN yum -y install ansible vim curl deltarpm wget sudo
RUN yum -y install yum-utils
RUN yum -y install python-devel
RUN yum -y install postgresql
RUN yum -y install httpd
RUN yum -y install net-tools
# centos7出现 bash: ip: command not found
RUN yum -y install initscripts




#ENV LC_ALL=zh_CN.UTF-8
#RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
#sed -i '13'd /etc/yum.conf && \
#yum install -y --nogpgcheck wget kde-l10n-Chinese glibc-common && \
#mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup && \
#wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo && \
#wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo && \
#yum makecache && \
#rm -rf /var/cache/yum/* && \
#echo -e 'export LANG="zh_CN.UTF-8"\nexport LC_ALL="zh_CN.UTF-8"' > /etc/locale.conf && \
#source /etc/locale.conf
