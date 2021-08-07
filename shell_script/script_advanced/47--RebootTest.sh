#!/bin/bash
#脚本功能：重启测试脚本
#脚本思路：
#使用方法：配合其他几个脚本使用，45--LongTestTools.sh这个脚本已经把另外的这些脚本整合起来了，所以最终执行时应该使用45
#使用环境：V10-desktop不要改这些脚本的名字

uusrname=`cat /var/tmp/LogNames`;
total=`cat /var/tmp/LogRebootNo`;
Timeout=30;
timeall=$(($Timeout*10))

if [ ! -e /etc/xdg/autostart/RebootTest.desktop ]; then 
	echo -e  "[Desktop Entry]\nEncoding=UTF-8\nName=RebootTest\nType=Application\nExec=47--RebootTest.sh --autostart\nTerminal=false\nType=Application\nX-UKUI-AutoRestart=true\nOnlyShowIn=UKUI\nX-UKUI-Autostart-Phase=Application\nNoDisplay=true">/etc/xdg/autostart/RebootTest.desktop
	chmod 666 /etc/xdg/autostart/RebootTest.desktop
fi

if [ ! -e /var/tmp/LogRebootTest ] ;then
	echo "0">/var/tmp/LogRebootTest
	chmod 666 /var/tmp/LogRebootTest
fi

var=`cat /var/tmp/LogRebootTest`
if [ $var -eq $total ]; then 
	touch /var/tmp/Rebootfinish.log
	zenity --info --text="您已经完成了重启测试，系统将重新启动以恢复设置。"
	sync
	sleep 2
	sync
	reboot
	#exit
fi
#if [ $var -gt $total ]; then 
#	echo "0">/var/tmp/LogRebootTest;
#	var=`cat /var/tmp/LogRebootTest`;
#fi
let Addvar=$var+1
if [ $var -le $total ]; then  
        for ((i=10;i<$timeall;))
	do 
		let Timeout=$Timeout-1
		echo $i
		echo "#重启测试共$total次，系统将进行第$Addvar次重启测试，$Timeout秒后重启。"
		let i=$i+3
		sleep 1
	done | zenity --progress  --auto-close
	if [ `echo "$?"` -ne 0 ]; then 
		touch /var/tmp/RebootCancel.log
		zenity --info --text="您取消了重启测试，系统将重新启动以恢复设置"
		sync
		sleep 2
		sync
		reboot
		#exit
	fi

	echo $Addvar > /var/tmp/LogRebootTest
	sleep 2	
	sync
	reboot;
fi
