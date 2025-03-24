# 使用 Node.js 20.10.0 作为基础镜像（已包含 Ubuntu、Yarn）
FROM node:20.10.0

# 设置工作目录
WORKDIR /app

# 安装 Ruby 和 Capistrano
RUN apt-get update && \
    apt-get install -y ruby && \
    gem install capistrano -v 3.17

# 安装必要的软件包
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    vim \
    curl \
    wget \
    git \
    build-essential \
    sudo \
    net-tools \
    iputils-ping \
    nginx \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 配置 SSH
RUN mkdir /var/run/sshd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# 创建 .ssh 目录并设置权限
RUN mkdir -p /root/.ssh && \
    touch /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/authorized_keys

# 拷贝 Nginx 配置文件
COPY nginx.conf /etc/nginx/nginx.conf

# 暴露端口
EXPOSE 5173 22

# 启动 SSH 服务
CMD ["/usr/sbin/sshd", "-D"]