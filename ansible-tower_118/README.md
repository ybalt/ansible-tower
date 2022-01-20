
### 打包

```shell
docker build --no-cache --squash -t ansible-tower:1.4 .
```

### 构建

```shell
docker run -d -it -p 80:80 -p 443:443 --name tower14 --privileged=true --net=host ansible-tower:1.4 /usr/sbin/init
docker exec -it tower14  /bin/bash
```


### 进入

```shell
docker exec -it tower14  /bin/bash
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

### 异常处理
Unable to start service nginx: Job for nginx.service failed because the control process exited with error code.
 Failed to start The nginx HTTP and reverse proxy server.
### linux关闭80端口

```shell
lsof -i :80|grep -v "PID"|awk '{print "kill -9",$2}'|sh
```
