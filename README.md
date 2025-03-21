#### docker 命令

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
```
