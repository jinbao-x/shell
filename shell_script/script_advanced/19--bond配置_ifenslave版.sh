#!/bin/bash
#脚本功能：双网卡绑定bond
#脚本思路：ifenslave方式的配bond重启后会失效，因此，添加到rc.local文件中
#使用方法：先修改脚本内变量值，在=后边加上需要修改的内容。在终端运行试过之后没问题后，可以将此脚本内的内容复制到/etc/rc.d/rc.local文件末尾
#使用环境：不限，先加权限再执行
#脚本编写：张瑞--国防事业本部

$IP=
$netmask=
$ens1=
$ens2=
modprobe bonding miimon=100 mode=1
sleep 2
ifconfig bond0 $IP netmask $netmask up
ifenslave bond0 $ens1 $ens2

sleep 3
ifconfig | grep bond0 -A 7
cat /proc/net/bonding/bond0
