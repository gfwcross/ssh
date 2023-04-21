#!/bin/bash

# 开启 SSH 服务
/usr/sbin/sshd -D &

# ngrok 映射本地 22 端口
ngrok tcp 22 --log=stdout
