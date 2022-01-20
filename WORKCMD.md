

## 上传

### 1.1 打上标签
[root@docker3 ~]# docker tag ansible-tower:1.5 docker.io/username/ansible-tower:1.5
### 1.2 用户登录
[root@docker3 ~]# docker login docker.io/username
Username: username
Password: XXXX
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
### 1.3 上传镜像
[root@docker3 ~]# docker push docker.io/username/ansible-tower:1.5
The push refers to repository [docker.io/username/ansible-tower]
7932ca5a463a: Pushed
565d366ac735: Pushed
ae85981c3054: Pushed
174f56854903: Pushed
1.5: digest: sha256:4d6c49882c7042a26e42afbf590b083ae109bef10c30a921a690f9409ec1d4fa size: 1147

## 下载

### 1.1 用户登录
[root@docker2 ~]# docker login docker.io/username
Username: username
Password:
Error response from daemon: Get https://docker.io/username/v2/: http: server gave HTTP response to HTTPS client
### 1.2 异常处理
> 提示说明：正常就忽略
### 1.2.1 修改配置
[root@docker2 ~]# vim /usr/lib/systemd/system/docker.service

line14: ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock --insecure-registry hub.docker.com
1.2.2 服务重启
[root@docker2 ~]# systemctl daemon-reload && systemctl restart docker

### 1.3 重新登录
[root@docker2 ~]# docker login docker.io/username
Username: username
Password:
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
### 1.4 下载容器
[root@docker2 ~]# docker pull docker.io/username/ansible-tower:1.5
### 1.5 下载容器
[root@docker2 ~]# docker run -d -it -p 443:443 -p 80:80 --name tower15 --privileged=true docker.io/username/ansible-tower:1.5 /usr/sbin/init
### 1.5.1 端口占用关闭
[root@docker2 ~]# lsof -i :80|grep -v "PID"|awk '{print "kill -9",$2}'|sh
[root@docker2 ~]# lsof -i :443|grep -v "PID"|awk '{print "kill -9",$2}'|sh
### 1.6 日志查询
[root@docker2 ~]# docker logs tower15
### 1.7 页面访问
访问地址：http:IP
账号密码：admin/admin

