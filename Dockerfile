# Ansible Tower Dockerfie

FROM ubuntu:14.04

MAINTAINER mittell@gmail.com

ENV ANSIBLE_TOWER_VER 3.1.2
ENV PG_DATA /var/lib/postgresql/9.4/main

RUN locale-gen "en_US.UTF-8" \
    && export LC_ALL="en_US.UTF-8" \
    && dpkg-reconfigure locales

RUN apt-get update

RUN apt-get install -y software-properties-common \ 
    && apt-add-repository ppa:fkrull/deadsnakes-python2.7

RUN apt-get update

RUN apt-get upgrade

#RUN apt-get install -y software-properties-common \
#    && apt-add-repository ppa:ansible/ansible \
#    && apt-get install -y ansible
RUN apt-get install -y gcc locales libssl-dev python-setuptools python-simplejson python2.7 python2.7-dev build-essential \
    && easy_install pip

RUN pip install ansible certifi==2015.04.28

ADD http://releases.ansible.com/awx/setup/ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz /opt/ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz

RUN cd /opt && tar -xvf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
    && rm -rf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
    && mv ansible-tower-setup-${ANSIBLE_TOWER_VER} /opt/tower-setup


ADD tower_setup_conf.yml /opt/tower-setup/tower_setup_conf.yml
ADD inventory /opt/tower-setup/inventory

RUN mkdir /var/log/tower && cd /opt/tower-setup \
    && ./setup.sh

VOLUME ${PG_DATA}
VOLUME /certs

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

EXPOSE 443 8080

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["ansible-tower"]


