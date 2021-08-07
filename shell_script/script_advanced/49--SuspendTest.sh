#!/bin/bash
#脚本功能：待机测试脚本
#脚本思路：
#使用方法：配合其他几个脚本使用，45--LongTestTools.sh这个脚本已经把另外的这些脚本整合起来了，所以最终执行时应该使用45
#使用环境：V10-desktop不要改这些脚本的名字

total=`cat /var/tmp/LogSuspendNo`
Timeout=30;
timeall=$(($Timeout*10))
while true
do
	if [ ! -e /var/tmp/logSuspendTest ] ;then 
		echo "0" > /var/tmp/logSuspendTest
		chmod 666 /var/tmp/logSuspendTest
	fi
	var=`cat /var/tmp/logSuspendTest`
	if [ $var -eq $total ]; then  
		zenity --info --text="您已经完成了系统待机测试";
		echo "0" >  /var/tmp/logSuspendTest;
		echo "0" >  /var/tmp/LogSuspendNo;
		exit ;
	fi
	if [ $var -gt $total ];then 
		echo "0" > /var/tmp/logSuspendTest;
		var=`cat /var/tmp/logSuspendTest`
	fi
	let Addvar=$var+1;
	if [ $var -le $total ]; then  
        	for ((i=10;i<$timeall;));do
			let Timeout=$Timeout-1;
			echo $i;
			echo "#总共待机测试$total次,当前待机第$Addvar次.$Timeout秒后待机."; 
			sleep 1;
			let i=$i+3;
		done | zenity --progress  --auto-close ;
		if [ `echo "$?"` -ne 0 ]; then 
			zenity --info --text="您取消了系统待机测试";
			echo "0" >  /var/tmp/logSuspendTest;
			echo "0" >  /var/tmp/LogSuspendNo;
			exit;
		fi
		echo $Addvar > /var/tmp/logSuspendTest;
		echo "+60"> /sys/class/rtc/rtc0/wakealarm;
		echo  mem > /sys/power/state;
	fi
done
