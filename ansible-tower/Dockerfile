# Ansible Tower Dockerfie
FROM ansible-centos:v0.1

MAINTAINER lucky

WORKDIR /vdb/tower

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

ENV ANSIBLE_TOWER_VER 3.8.5-1
COPY inventory inventory
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY ./pkg/ansible-tower-setup-3.8.5-1.tar.gz ansible-tower-setup-3.8.5-1.tar.gz
COPY ./licensing/licensing.py licensing.py

RUN mkdir -p /var/log/tower \
	&& tar -zxvf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
	&& rm -f ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
	&& mv -f inventory ansible-tower-setup-${ANSIBLE_TOWER_VER}/inventory

RUN yum -y install net-tools
RUN yum -y install initscripts
RUN mkdir -p /var/log/tower
#RUN cd /vdb/tower/ansible-tower-setup-${ANSIBLE_TOWER_VER} && ./setup.sh

## 运行服务 docker run -d -it -p 443:443 --name tower11 --privileged=true --net=host --rm ansible-tower:1.1 /usr/sbin/init
## 进入安装 docker exec -it tower11  /bin/bash
#RUN cd /vdb/tower/ansible-tower-setup-3.8.5-1 && ./setup.sh
#RUN cd /var/lib/awx/venv/awx/lib/python3.6/site-packages/awx/main/utils/ && cp licensing.py licensing.py.bak00
#RUN mv -f /vdb/tower/licensing.py /var/lib/awx/venv/awx/lib/python3.6/site-packages/awx/main/utils/licensing.py
#RUN ansible-tower-service restart
#RUN chmod +x /vdb/tower/docker-entrypoint.sh

# volumes and ports
#VOLUME ["${PG_DATA}", "${AWX_PROJECTS}", "/certs"]
EXPOSE 80 443

CMD ["/docker-entrypoint.sh", "ansible-tower"]
