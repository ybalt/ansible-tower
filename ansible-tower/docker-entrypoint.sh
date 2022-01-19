#!/bin/bash
# Modified for Ansible Tower 3.x from https://github.com/ybalt/ansible-tower/blob/master/docker-entrypoint.sh

set -e

NGINX_CONF=/etc/nginx/nginx.conf

trap "kill -15 -1 && echo all proc killed" TERM KILL INT

if [ "$1" = "ansible-tower" ]; then
	if [[ $SERVER_NAME ]]; then
		echo "add $SERVER_NAME to server_name"
		cat $NGINX_CONF | grep -q "server_name _" \
		&& sed -i -e "s/server_name\s_/server_name $SERVER_NAME/" $NGINX_CONF
	fi
	
	if [[ -a /certs/tower.cert && -a /certs/tower.key ]]; then
		echo "copy new certs"
		cp -r /certs/tower.cert /etc/tower/tower.cert
		chown awx:awx /etc/tower/tower.cert
		cp -r /certs/tower.key /etc/tower/tower.key
		chown awx:awx /etc/tower/tower.key
	fi
	
	if [[ -a /certs/license ]]; then
		echo "copy new license"
		cp -r /certs/license /etc/tower/license
		chown awx:awx /etc/tower/license
	fi
	
	ansible-tower-service start
	sleep inf & wait
else
	exec "$@"
fi
