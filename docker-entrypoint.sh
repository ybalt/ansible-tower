#!/bin/bash
set -e

APACHE_CONF=/etc/apache2/conf-enabled/awx-httpd-443.conf

trap "kill -15 -1 && echo all proc killed" TERM KILL INT

if [ "$1" = 'ansible-tower' ]; then
	if [[ $SERVER_NAME ]]; then
		echo "add ServerName to $SERVER_NAME"
		head -n 1 $APACHE_CONF | grep -q "^ServerName" \
		&& sed -i -e "s/^ServerName.*/ServerName $SERVER_NAME/" $APACHE_CONF \
		|| sed -i -e "1s/^/ServerName $SERVER_NAME\n/" $APACHE_CONF
	fi
	if [[ -a /certs/domain.crt && -a /certs/domain.key ]]; then
		echo "copy new certs"
		cp -r /certs/domain.crt /etc/tower/tower.cert
		chown awx:awx /etc/tower/tower.cert
		cp -r /certs/domain.key /etc/tower/tower.key
		chown awx:awx /etc/tower/tower.key
	fi
	if [[ -a /certs/license ]]; then
		echo "copy new license"
		cp -r /certs/license /etc/tower/license
		chown awx:awx /etc/tower/license
	fi
	ansible-tower-service start
	#sleep 10
	#watch "netstat -an | grep -E '443.*LISTEN'"
	sleep inf & wait
else
	exec "$@"
fi

