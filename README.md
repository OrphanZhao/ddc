# use ruby capistrano deploy docker container

#### 部署步骤

环境准备

- docker
- ruby
- bundler

前期准备

- 构建镜像
- 启动`docker`容器
- 配置 ssh

部署分支

- main

部署命令

```bash
bundle install
cap production deploy
```

#### 常用命令

```bash
# 构建镜像
docker build -t vite-image .

# 启动容器
docker run -d \
  -p 5173:5173 \
  -p 2222:22 \
  -e SSH_PUBLIC_KEY="$(cat ~/.ssh/id_rsa.pub)" \
  --name react-app \
  vite-image

# 进入容器
docker exec -it react-app bash

# 启动nginx
nginx

# 重启nginx
service nginx restart

# 生成ssh key
ssh-keygen -t rsa -b 4096 -C "xxx.com"

# ssh进入容器
ssh -i ~/.ssh/id_rsa root@localhost -p 2222
```
