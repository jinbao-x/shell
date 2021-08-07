#!/bin/bash
#脚本功能：自动重启的脚本，有计重启次数
#脚本思路：Total文件里为重启次数
#使用方法：如果想要取消重启，就echo任意内容到StatusFile文件中,示例：echo xxx > /tmp/status_file
#使用环境：将此脚本绝对路径加入到rc.local文件中
#脚本编写：徐金宝--国防事业本部

Delay=120		#这个时间强烈建议设置大一些，避免还没进入桌面，就又开始重启，确认了大概多少秒之后系统进入桌面的情况下再改小这个值
Times=30
StatusFile=/tmp/status_file
Temp=/tmp/tmp_file
Total=/tmp/total_file

#状态文件、临时文件、计数文件如果不存在则创建
if [ ! -f $StatusFile ]
then
	touch $StatusFile
	chmod 777 $StatusFile
fi
if [ ! -f $Temp ]
then
	touch $Temp
	chmod 777 $Temp
fi
if [ ! -f $Total ]
then
	touch $Total
	chmod 777 $Total
fi


Count=`cat $Temp | wc -l`
echo $Count > $Total					#相当于每次开机第一件事就是计数，然后脚本就开始睡觉，如果在睡觉期间打破了这种状态，那么就不会重启了

sleep $Delay

#判断状态文件，文件内容非空时，会执行重启命令
Num=`cat $StatusFile | wc -l`
if [ -f $StatusFile ] && [ $Num == 0 ] && [ $Count -lt $Times ]
then
	echo xxx >> $Temp
	reboot &
fi
