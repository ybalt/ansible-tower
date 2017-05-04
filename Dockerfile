# Ansible Tower Dockerfie
FROM ubuntu:trusty

LABEL maintainer mittell@mgail.com, reuben.stump@gmail.com

RUN apt-get update

# Set locale
RUN locale-gen "en_US.UTF-8"
RUN export LC_ALL="en_US.UTF-8"
RUN dpkg-reconfigure locales

ENV ANSIBLE_TOWER_VER 3.1.2
ENV PG_DATA /var/lib/postgresql/9.4/main

RUN apt-get install -y software-properties-common \
	&& apt-add-repository -y ppa:fkrull/deadsnakes-python2.7

RUN apt-get update
RUN apt-get install -y libpython2.7

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


