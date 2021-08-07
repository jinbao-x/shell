#!/bin/bash
#脚本功能：根据指定大小截断日志文件，保留截断后的最新的日志
#脚本思路：使用split截断工具
#使用方法：放到rc.local里，每次开机的时候执行一次
#使用环境：无校准时钟时使用
#脚本编写：徐金宝--国防事业本部

LogName=/var/log/syslog		#日志路径
TempUrl=/tmp			#临时目录

sudo cd /tmp
sudo split -b 500M -d $LogName label_
count=00
for i in `ls | grep label_`
do
	j=${i:6:2}
	if [ $j -gt $count ]
	then
		count=$j
	fi
done
sudo more label_$count > $LogName
sudo rm -rf $TempUrl/label_*

<< EOF
为什么不使用logrotate进行日志管理？是因为：
先前接触的工作环境是这样的：客户的机器因为要上飞机，没有硬件时钟可以为之校时，也没有网络为之校时，而logrotate是依据时间进行日志轮转的
若崩溃的程序不间断的往日志里打印日志，就可能会出现一定时间内日志爆满的情况，从而因为这个带来黑屏等其他问题
#使用logrotate进行日志管理请参见第26个脚本
EOF
