# ansible-tower
Ansible Tower dockerized

Ansible Tower (AT) is a GUI for great Ansible tool, that provides powerful remote agentless hosts management via SSH. Ansible Tower is free for case <=10 nodes, but complex to install and support restricted OS list.

To help users get try AT with Docker benefits, I've create Docker image that potentially run on any mashine with Docker installed. This version install only local variant - all services(Redis, MongoDB, PostreSQL) inside container. 

Prepereqisites:
- Docker 1.8 and later (older version may work but untested)

To run Ansible Tower there is two ways:
Create container without external data mounts so if you remove container, all Postgres data that used by AT is lost:
```
# docker run -t -d -p 443:443 -v ~/certs:/certs -e SERVER_NAME=localhost --name=ast ybalt/ansible-tower
```
OR
Create separate data-only container, it will save your DB data even if ast container removed(upgrade, etc):
```
# docker create -v /var/lib/postgresql/9.4/main --name astdata ybalt/ansible-tower /bin/true
# docker run -t -d --volumes-from astdata -v ~/certs:/certs -e SERVER_NAME=localhost -p 443:443 --name=ast ybalt/ansible-tower
```

You may use mapping for /certs as above, to add certificate and license file. Startup script will copy files with this Filenames to /etc/tower:

~/certs/domain.crt
~/certs/domain.key
~/certs/domain.license

change SERVER_NAME env to your mashine ip/name for make HTTPS works (certificate should be valid for this name)

Initial credentials: user:admin pass:000
All passwords for all other services is '000'

Limitations:
Only local DBs supported

Please keep in mind, if you remove ast container, some data may be lost even if you use 
data-only container, as in Postgres AT store only projects/tasks/results.

Trademarks:
Ansible and Ansible Tower are trademarks of Ansible, Inc.
Docker is a registered trademark of Docker, Inc.




Ansible and Ansible Tower are trademarks of Ansible, Inc.
