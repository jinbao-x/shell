#!/bin/bash
#脚本功能：休眠测试脚本
#脚本思路：
#使用方法：配合其他几个脚本使用，45--LongTestTools.sh这个脚本已经把另外的这些脚本整合起来了，所以最终执行时应该使用45
#使用环境：V10-desktop不要改这些脚本的名字
#swapdisk=/dev/sda8

total=`cat /var/tmp/LogSleepNo`
Timeout=30;
timeall=$(($Timeout*10))
swapon -a;
while true
do
	if [ ! -e /var/tmp/logSleepTest ] ;then 
		echo "0" > /var/tmp/logSleepTest
	fi
	var=`cat /var/tmp/logSleepTest`
	if [ $var -eq $total ]; then  
		zenity --info --text="您已经完成了系统睡眠测试";
		echo "0" > /var/tmp/logSleepTest;
		echo "0" > /var/tmp/LogSleepNo;
		exit ;
	fi
	if [ $var -gt $total ]; then 
		echo "0" > /var/tmp/logSleepTest;
		 var=`cat /var/tmp/logSleepTest`;
	fi
	let Addvar=$var+1;
	if [ $var -le $total ]; then  
        	for ((i=10;i<$timeall;));do
			let Timeout=$Timeout-1;
			echo $i;
			echo "#共休眠测试$total次,当前睡眠第$Addvar次.$Timeout秒后休眠."; 
			sleep 1;
			let i=$i+3;
		done | zenity --progress  --auto-close ;
		if [ `echo "$?"` -ne 0 ]; then 
			zenity --info --text="您取消了休眠测试";
			echo "0" > /var/tmp/logSleepTest;
			echo "0" > /var/tmp/LogSleepNo;
			exit;
		fi
		echo $Addvar > /var/tmp/logSleepTest;
		echo "+60"> /sys/class/rtc/rtc0/wakealarm;
		#echo shutdown > /sys/power/disk; 
		echo reboot > /sys/power/disk; 
		echo disk > /sys/power/state;
	fi
done

