# Ansible Tower Dockerfie
FROM ansible-centos:v0.1

WORKDIR /vdb/tower

ENV ANSIBLE_TOWER_VER 3.8.5-1
COPY inventory inventory
COPY ./pkg/ansible-tower-setup-3.8.5-1.tar.gz ansible-tower-setup-3.8.5-1.tar.gz
COPY ./licensing/licensing.py licensing.py

RUN mkdir -p /var/log/tower \
	&& tar xvf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
	&& rm -f ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
	&& mv inventory ansible-tower-setup-${ANSIBLE_TOWER_VER}/inventory

RUN yum -y install net-tools
RUN mkdir -p /var/log/tower

#RUN cd /vdb/tower/ansible-tower-setup-${ANSIBLE_TOWER_VER} && ./setup.sh


#RUN cd /var/lib/awx/venv/awx/lib/python3.6/site-packages/awx/main/utils/
#RUN cp licensing.py licensing.py.bak00
#RUN mv /vdb/tower/licensing.py /var/lib/awx/venv/awx/lib/python3.6/site-packages/awx/main/utils/licensing.py
#RUN ansible-tower-service restart

EXPOSE 443
