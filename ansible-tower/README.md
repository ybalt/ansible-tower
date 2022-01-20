
### 打包

```shell
docker build --no-cache --squash -t ansible-tower:2.1 .
```

### 构建

```shell
docker run -d -it -p 443:443 -p 80:80 --name tower18 --privileged=true ansible-tower:2.1 /usr/sbin/init
docker exec -it tower18 /bin/bash
```

### 进入

```shell
docker exec -it tower18  /bin/bash
```

### 拷贝

#### 从容器拷贝文件到宿主机

```shell
docker cp mycontainer:/opt/testnew/file.txt /opt/test/
```

#### 从宿主机拷贝文件到容器

```shell
docker cp /opt/test/file.txt mycontainer:/opt/testnew/
```

> 注意: 不管容器有没有启动，拷贝命令都会生效。


### 重新生成
```shell
docker images
docker tag ansible-centos:v0.1 huangbosbos/ansible-centos:v0.1
docker push huangbosbos/ansible-centos:v0.1

docker tag ansible-tower:2.0 huangbosbos/ansible-tower:2.0
docker push huangbosbos/ansible-tower:2.0

docker tag ansible-tower:2.1 huangbosbos/ansible-tower:2.1
docker push huangbosbos/ansible-tower:2.1
```

#### 保存镜像

Docker 提供了一个 docker commit 命令，可以将容器的存储层保存下来成为镜像
docker commit [选项] <容器ID或容器名> [<仓库名>[:<标签>]]

```shell
docker commit \
    --author "Lucky <huangbosbos@gmail.com>" \
    --message "install ansible tower 16" \
    tower16\
    ansible-tower:2.0


docker commit \
    --author "Lucky <huangbosbos@gmail.com>" \
    --message "install ansible tower 18" \
    tower18\
    ansible-tower:2.1
```

### 端口冲突

Unable to start service nginx: Job for nginx.service failed because the control process exited with error code.
 Failed to start The nginx HTTP and reverse proxy server.
 
### linux关闭80|443端口
```shell
lsof -i :80|grep -v "PID"|awk '{print "kill -9",$2}'|sh

lsof -i :443|grep -v "PID"|awk '{print "kill -9",$2}'|sh
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

## 参考

https://github.com/andrefernandes/docker-ansible-tower

https://github.com/ybalt/ansible-tower

https://hub.docker.com/r/ybalt/ansible-tower/

git tag -a v0.1 -m "dev0.1" && git push origin --tags
