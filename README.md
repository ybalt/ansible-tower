# ansible-tower
Ansible Tower dockerized

Ansible Tower (AT) is a GUI for great Ansible tool, that provides powerful remote agentless hosts management via SSH. Ansible Tower is free for case <=10 nodes, but complex to install and support restricted OS list.

To help users get try AT with Docker benefits, I've create Docker image that potentially run on any mashine with Docker installed. This version install only local variant - all services(Redis, MongoDB, PostreSQL) inside container. 

Prepereqisites:
- Docker 1.8 and later (older version may work but untested)

To run Ansible Tower there is two ways:
Create container without external data mounts so if you remove container, all Postgres data that used by AT is lost:
# docker run -t -d -p 443:443 --name=ast ybalt/ansible-tower

OR

Create separate data-only container, it will save your DB data even if ast container removed(upgrade, etc):
# docker create -v /var/lib/postgresql/9.4/main --name astdata ybalt/ansible-tower /bin/true
# docker run -t -d --volumes-from astdata -p 443:443 --name=ast ybalt/ansible-tower

Initial credentials: user:admin pass:000
At first run AT asks for license, if you build it manually, put it into license file. All passwords for all other services is '000'

Limitations:
Apache2 HTTPS not configured for external access
Only local DBs supported

Please keep in mind, if you remove ast container, license info will be lost (and may be some any other data) even if you use 
data-only container, as in Postgres AT store only projects/tasks/results.

Trademarks:
Ansible and Ansible Tower are trademarks of Ansible, Inc.
Docker is a registered trademark of Docker, Inc.







Ansible and Ansible Tower are trademarks of Ansible, Inc.
