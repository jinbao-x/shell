#!/bin/bash
#脚本功能：记录io信息
#脚本思路：超过一定行触发截断，保留较新的日志
#使用方法：该脚本是死循环，不用了记得kill掉
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

dev="/dev/sda2"		#需要监控的分区
maxline="999999"	#io日志行数上限，超过则触发保存最新的remains行日志
remains="99999"		#保留的最新的日志行数

ls /var/log/io &> /dev/null
if [ $? != 0 ]
then
	sudo touch /var/log/io
	sudo chmod 777 /var/log/io
	sudo touch /var/log/test
	sudo chmod 777 /var/log/test
fi

#死循环，不停地记录当时的io相关值到/var/log/io里
while :
do
	io=`sudo iostat -d -x -k $dev`
	sudo echo -e "\n" >> /var/log/io
	sudo echo "$io" >> /var/log/io
	line=`sudo more /var/log/io | wc -l`
	if [ "$line" -gt "$maxline" ]
	then
		sudo tail -"$remains" /var/log/io > /var/log/test
		sudo more /var/log/test > /var/log/io 
	fi
	
done
