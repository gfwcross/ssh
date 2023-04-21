FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server curl

# 创建 SSH 登录账户，密码为 "123456"
RUN useradd -rm -d /home/test -s /bin/bash -p $(echo "123456" | openssl passwd -1 -stdin) test

# 开启 SSH 服务
RUN mkdir /var/run/sshd \
 && sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/" /etc/ssh/sshd_config \
 && echo "PermitRootLogin yes" >> /etc/ssh/sshd_config \
 && echo "Subsystem sftp /usr/lib/openssh/sftp-server" >> /etc/ssh/sshd_config

# 安装 ngrok
RUN curl -o /ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
 && unzip /ngrok.zip -d /usr/local/bin \
 && rm /ngrok.zip

# 添加启动脚本，用于开启 SSH 和 ngrok 映射
COPY run.sh /run.sh
CMD ["/run.sh"]
