#!/bin/sh
FRP_VERSION="0.32.1"
REPO="eddiechen2011/frps"
WORK_PATH=$(dirname $(readlink -f $0))

# 创建frp文件夹
mkdir -p /root/frp && \
# 下载并移动frps文件
wget -P ${WORK_PATH} https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_amd64.tar.gz && \
tar -zxvf frp_${FRP_VERSION}_linux_amd64.tar.gz && \
cd frp_${FRP_VERSION}_linux_amd64 && \
mv frpc /root/frp && \
# 下载frpc.in和frpc.service
wget -P /root/frp https://raw.githubusercontent.com/${REPO}/master/frpc.ini && \
wget -P /lib/systemd/system https://raw.githubusercontent.com/${REPO}/master/frpc.service && \
systemctl daemon-reload && \
# 启动frps
sudo systemctl start frpc && \
sudo systemctl enable frpc && \
# 删除多余文件
cd ${WORK_PATH} && \
rm -rf frp_${FRP_VERSION}_linux_amd64 frp_${FRP_VERSION}_linux_amd64.tar.gz frpc_linux_install.sh
echo "=======================================================" &&\
echo -e "\033[32m安装成功,请先修改 frps.ini 文件,确保格式及配置正确无误!\033[0m" && \
echo -e "\033[31mvi /root/frp/frps.ini \033[0m" && \
echo -e "\033[32m修改完毕后执行以下命令重启服务:\033[0m" && \
echo -e "\033[31msudo systemctl restart frps\033[0m" && \
echo "======================================================="
