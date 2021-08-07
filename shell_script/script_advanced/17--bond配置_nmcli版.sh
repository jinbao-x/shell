#!/bin/bash
#脚本功能：通过nmcli方式配bond双网卡绑定
#脚本思路：添加一个Team，然后伴随两个slave，Team的配置参考nmcli-examples的man帮助，输入/EXAMPLES查找，Team的策略参考Teamd.conf的man帮助
#使用方法：使用前修改脚本内IP以及两个网卡名称
#使用环境：需要运行NetworkManager
#脚本编写：徐金宝--国防事业本部

IP=192.168.87.111
ETH1=ens1
ETH2=ens2
nmcli con add type team con-name Team1 ifname Team1 config '{"runner": {"name": "activebackup"}}'
nmcli con add type team-slave con-name Team1-slave1 ifname "$ETH1" master Team1
nmcli con add type team-slave con-name Team1-slave2 ifname "$ETH2" master Team1
nmcli con mod Team1 ipv4.method manual ipv4.addresses "$IP" connection.autoconnect yes
nmcli con mod Team1-slave1 connection.autoconnect yes
nmcli con mod Team2-slave2 connection.autoconnect yes
nmcli connection up Team1
nmcli connection up Team1-slave1
nmcli connection up Team1-slave2
systemctl restart network
systemctl disable firewalld.service
