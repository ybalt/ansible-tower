## 构建属于Ansible的ContOS
### 打包
docker build --no-cache --squash -t ansible-centos:v0.1 .

### 引用

```
FROM ansible-centos:v0.1
```


### 其他

```
### 构建
docker run --privileged=true --name tower04 -d -it --rm ansible-centos:v0.1 /usr/sbin/init
docker run -d -it -p 443:443 -p 80:80 --privileged=true --name tower05 ansible-tower:0.5 /usr/sbin/init
docker run -d -it --network bridge -p 443:443 -p 80:80 --privileged=true --name tower05 ansible-tower:0.5 /usr/sbin/init

### 进入
docker exec -it tower05  /bin/bash

### 拷贝

#### 从容器拷贝文件到宿主机
docker cp mycontainer:/opt/testnew/file.txt /opt/test/

#### 从宿主机拷贝文件到容器
docker cp /opt/test/file.txt mycontainer:/opt/testnew/

> 注意: 不管容器有没有启动，拷贝命令都会生效。

```
