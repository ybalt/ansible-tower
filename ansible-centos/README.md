## 构建属于Ansible的ContOS

### 打包
docker build --no-cache --squash -t ansible-centos:v0.1 .

### 引用
```
FROM ansible-centos:v0.1
```
