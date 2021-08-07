#!/bin/bash
#脚本功能：监控cpu温度
#脚本思路：使用sensors工具检测温度，输出结果重定向到日志文件
#使用方法：事先下载好sensors工具，软件名应该叫lm-sensors
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

if [ ! -f /var/log/sensors.log ]
then
	sudo touch /var/log/sensors.log
	sudo chmod 777 /var/log/sensors.log
fi
while :
do
	sudo date >> /var/log/sensors.log
	sudo sensors >> /var/log/sensors.log
	sudo echo -e "\n" >> /var/log/sensors.log
	sleep 2
done
