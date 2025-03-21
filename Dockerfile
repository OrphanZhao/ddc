# 使用 Ubuntu 作为基础镜像
FROM ubuntu

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    openssh-server \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# 创建 SSH 目录
RUN mkdir /var/run/sshd

# 配置 SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config

# 创建 .ssh 目录并设置权限
RUN mkdir -p /root/.ssh && chmod 700 /root/.ssh

# 复制公钥到 authorized_keys
COPY /home/ubuntu/.ssh/authorized_keys /root/.ssh/authorized_keys
RUN chmod 600 /root/.ssh/authorized_keys

# 暴露 SSH 端口
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]