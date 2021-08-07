#!/bin/bash
#脚本功能：测试工具(关机、重启、待机、休眠测试)
#脚本思路：判断zenity界面里选中的哪一项，就调用哪一个脚本
#使用方法：配合其他几个脚本使用，45--LongTestTools.sh这个脚本已经把另外的那些脚本整合起来了，所以最终执行时应该使用这个
#使用环境：V10-desktop不要改这些脚本的名字

set -e
#Every script you write should include set -e at the top.
#This tells bash that it should exit the script if any statement returns a non-true return value. 
#The benefit of using -e is that it prevents errors snowballing into serious issues when they could have been caught earlier. 
#Again, for readability you may want to use set -o errexit.

uid=`echo "$UID"`;
if [ $uid -ne 0 ];then
	zenity --info --text="该程序每次以ROOT身份执行";
	exit;
fi;
SHUTDOWN="关机测试";
REBOOT="重启测试";
SUSPEND="待机测试";
SLEEP="休眠测试";
echo `logname` >/var/tmp/LogNames;
usrname=`cat /var/tmp/LogNames`;
lightdm_conf="/etc/lightdm/lightdm.conf"
rc_etc="/etc/systemd/system/rc-local.service"
rc_lib="/lib/systemd/system/rc-local.service"
if [ -e $lightdm_conf ];then
	rm -rf /etc/lightdm/lightdm.conf
	echo '[Seat:*]' >> /etc/lightdm/lightdm.conf
	echo 'autologin-user='$usrname >> /etc/lightdm/lightdm.conf
else
	touch /etc/lightdm/lightdm.conf
	echo '[Seat:*]' >> /etc/lightdm/lightdm.conf
	echo 'autologin-user='$usrname >> /etc/lightdm/lightdm.conf
fi



SELECTION=`zenity --list --radiolist --title="测试工具(V10desktop)"  --text="选择您想操作的一项功能"  --column "" --column "请您选择" True "$SHUTDOWN"  Fasle "$REBOOT"   Fasle "$SUSPEND" Fasle "$SLEEP" `   

if [ -e $SELECTION ] ; then 
	exit;
fi
if [ "$SELECTION"  =  "$SHUTDOWN"  ] ;then
#	sed -i "100a autologin-user=$usrname" /etc/lightdm/lightdm.conf
	TestNo=` zenity  --entry --text="请您输入需要开关机测试的次数" `;
	if [ -e $TestNo ] ;then 
		exit 
	fi
	echo $TestNo > /var/tmp/LogBootNo;
	chmod 666 /var/tmp/LogBootNo;
	if [ ! -e /etc/rc.local ]; then
        echo -e "#!bin/sh\n/usr/sbin/43--BootReplace.sh\nexit 0"> /etc/rc.local
        chmod 777 /etc/rc.local;

else
	echo -e "#!bin/sh\n/usr/sbin/43--BootReplace.sh\nexit 0"> /etc/rc.local
        chmod 777 /etc/rc.local;
	fi
	if [ ! -e $rc_etc ];then
		ln -s $rc_lit $rc_etc
       
	fi
	44--BootTest.sh;
fi
if [ "$SELECTION"  =  "$REBOOT"  ]; then
#	sed -i "100a autologin-user=$usrname" /etc/lightdm/lightdm.conf
	#chmod 666 /etc/lightdm/lightdm.conf;

	#V7.0系统分区安装 当前boot下不存在引导文件
	#if [ -e /boot/grub.cfg ] ; then 
	#	sed -i  "s/timeout=15/timeout=5/g" /boot/grub.cfg
	#	sed -i  "s/timeout 15/timeout 5/g" /boot/boot.cfg
	#	sed -i  "s/timeout 15/timeout 5/g" /boot/boot.conf
	#fi
	TestNo=` zenity  --entry --text="请您输入需要重启测试的次数" `;
	if [ -e $TestNo ] ;then 
		exit 
	fi
	echo $TestNo > /var/tmp/LogRebootNo;
	chmod 666 /var/tmp/LogRebootNo;
	if [ ! -e /etc/rc.local ]; then
        echo -e "#!bin/sh\n/usr/sbin/46--RebootReplace.sh\nexit 0"> /etc/rc.local
        chmod 777 /etc/rc.local;

else
	echo -e "#!bin/sh\n/usr/sbin/46--RebootReplace.sh\nexit 0"> /etc/rc.local
        chmod 777 /etc/rc.local;
	fi
	if [ ! -e $rc_etc ];then
		ln -s $rc_lit $rc_etc
       
	fi
	47--RebootTest.sh;
fi
if [ "$SELECTION" = "$SUSPEND"  ] ;then
	TestNo=` zenity  --entry --text="请您输入需要待机测试的次数" `;
	if [ -e $TestNo ] ;then 
		exit 
	fi
	echo $TestNo > /var/tmp/LogSuspendNo;
	chmod 666 /var/tmp/LogSuspendNo;
	49--SuspendTest.sh;
fi
if [ "$SELECTION"  =  "$SLEEP"  ] ;then
	TestNo=` zenity  --entry --text="请您输入需要休眠测试的次数" `;
	if [ -e $TestNo ] ;then 
		exit 
	fi
	echo $TestNo > /var/tmp/LogSleepNo;
	chmod 666 /var/tmp/LogSleepNo;
	48--SleepTest.sh;
fi
