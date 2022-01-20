
### 打包
docker build --no-cache --squash -t ansible-tower:0.5 .

### 构建
docker run --privileged=true --name tower04 -d -it --rm ansible-tower:0.5 /usr/sbin/init

docker run -d -it -p 443:443 --privileged=true --name tower05 --rm ansible-tower:0.5 /usr/sbin/init

docker run -d -it --network bridge -p 443:443 --privileged=true --name tower05 --rm ansible-tower:0.5 /usr/sbin/init

### 进入
docker exec -it tower05  /bin/bash

### 拷贝

#### 从容器拷贝文件到宿主机
docker cp mycontainer:/opt/testnew/file.txt /opt/test/

#### 从宿主机拷贝文件到容器
docker cp /opt/test/file.txt mycontainer:/opt/testnew/

> 注意: 不管容器有没有启动，拷贝命令都会生效。




docker exec -it tower_03  /bin/bash


docker cp 44a8d6224bd6:/var/lib/awx/venv/awx/lib/python2.7/site-packages/tower_license/__init__.py  /root/ansible-tower/
docker cp /root/ansible-tower/__init__.py 44a8d6224bd6:/var/lib/awx/venv/awx/lib/python2.7/site-packages/tower_license/

cd /var/lib/awx/venv/awx/lib/python2.7/site-packages/tower_license/


修改完重新编译一下:
[root@test01 tower_license]# python -m py_compile __init__.py
[root@test01 tower_license]# python -O -m py_compile __init__.py
重启服务:
[root@test01 tower_license]# ansible-tower-service restart

### 拷贝

#### 从容器拷贝文件到宿主机
docker cp mycontainer:/opt/testnew/file.txt /opt/test/

#### 从宿主机拷贝文件到容器
docker cp /opt/test/file.txt mycontainer:/opt/testnew/

收藏
https://hub.docker.com/r/ybalt/ansible-tower/
https://github.com/ybalt/ansible-tower
https://10.XX.XX.XX/#/license
https://www.tracymc.cn/archives/1510


docker build --no-cache --squash -t ansible-tower:3.8.5-1 .



















