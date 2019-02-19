# Ansible Tower Dockerfie
FROM ubuntu:16.04

WORKDIR /opt

ENV ANSIBLE_TOWER_VER 3.2.1
ENV PG_DATA /var/lib/postgresql/9.6/main
ENV AWX_PROJECTS /var/lib/awx/projects
ENV LC_ALL "en_US.UTF-8"
ENV LANGUAGE "en_EN:en"
ENV LANG "en_US.UTF-8"
ENV DEBIAN_FRONTEND "noninteractive"
ADD http://releases.ansible.com/ansible-tower/setup/ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz
COPY docker-entrypoint.sh /docker-entrypoint.sh
COPY inventory inventory

RUN apt-get -qq update \
	&& apt-get -yqq upgrade \
	&& apt-get -yqq install \
			locales \
			gnupg2 \
			gnupg \
			libpython2.7 \
			python \
			python-pip \
			python-dev \
			ca-certificates \
			debconf \
			apt-transport-https \
			sudo \
	&& locale-gen "en_US.UTF-8" \
	&& echo "locales	locales/default_environment_locale	select	en_US.UTF-8" | debconf-set-selections \
	&& dpkg-reconfigure locales \
	&& mkdir -p /var/log/tower \
	&& tar xvf ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
	&& rm -f ansible-tower-setup-${ANSIBLE_TOWER_VER}.tar.gz \
	&& pip install ansible \
	&& mv inventory ansible-tower-setup-${ANSIBLE_TOWER_VER}/inventory

RUN cd /opt/ansible-tower-setup-${ANSIBLE_TOWER_VER} \
	&& ./setup.sh \
	&& chmod +x /docker-entrypoint.sh

# volumes and ports
VOLUME ["${PG_DATA}", "${AWX_PROJECTS}", "/certs",]
EXPOSE 443

CMD ["/docker-entrypoint.sh", "ansible-tower"]
