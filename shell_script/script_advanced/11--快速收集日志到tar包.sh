#!/bin/bash
#脚本功能：工作现场一键备份系统相关日志，以便排障
#脚本思路：先保存日志到/tmp目录下，最后打包成tar.gz包到当前目录
#使用方法：执行脚本时，可以加参数，加的参数会当做备份出来的日志名称，如果不加参数则默认以系统时间命名
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

CurDir=`pwd`				#当前目录
Time=`LANG=en date "+%Y%m%d%H%M%S"`	#当前时间
LogName=system-log-$Time		#默认保存的日志名称

#判断执行脚本时是否输入了参数
if [ $# -eq 0 ]
then
	echo "执行脚本时，未加参数，因此将使用默认名称保存日志！"
else
	LogName=$1
fi

TempUrl=/tmp/$LogName			#临时目录

#创建临时目录
sudo mkdir -p $TempUrl
sudo chmod -R 777 $TempUrl

#备份系统版本信息以及某些硬件信息
echo "系统版本是：" >> $TempUrl/version.txt 
cat /etc/.kyinfo >> $TempUrl/version.txt 2>&1
cat /etc/.productinfo >> $TempUrl/version.txt 2>&1
echo "内核版本是："  >> $TempUrl/version.txt
uname -a >> $TempUrl/version.txt
uname -r >> $TempUrl/version.txt
echo "cpu信息：" >> $TempUrl/version.txt
sudo lscpu >> $TempUrl/version.txt

#备份系统日志
sudo cp -r /var/log  $TempUrl/

#备份dmesg日志
sudo dmesg > $TempUrl/dmesg.txt

#备份xsession日志
sudo mkdir $TempUrl/xsession
for i in `ls -a ~/ | grep xsession`
do
        A=${i:1}                                #截取字符串，把.去掉保存在变量A里
        sudo cp -r ~/$i $TempUrl/xsession/$A
done

#备份历史操作
HISTFILE=~/.bash_history
set -o history
history >> $TempUrl/history.txt

#备份磁盘信息
mkdir $TempUrl/smart
for i in `lsblk | grep └─ | awk '{print $1}' | awk -F─ '{print $2}'`
do
        B=${i:0:3}
        smartctl -a /dev/$B > $TempUrl/smart/$B.txt
done

#打包日志
cd /tmp
sudo tar -czvf $CurDir/$LogName.tar.gz $LogName
sudo rm -rf $TempUrl
cd $CurDir
