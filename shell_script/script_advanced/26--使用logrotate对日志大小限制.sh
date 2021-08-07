#!/bin/bash
#脚本功能：为某个日志文件进行配置，以实现定期轮替日志
#脚本思路：使用logrotate日志管理，添加配置文件方式实现轮替
#使用方法：使用前请按需修改脚本内定义的变量
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

url='/var/log/'
name='test.log'
config_url='/etc/logrotate.d/'
config_name='test'

function config()
{
	cat << EOF > "$config_url$config_name"
        	$url$name {
                missingok               #如果日志文件丢失，则忽略并返回（不对日志文件进行轮替）
                notifempty              #仅当源日志文件非空时才对其进行轮替
                size 30M                #限制执行轮替时的日志文件大小，可以M、k等
                        compress        #允许用gzip压缩日志文件
                daily                   #指定轮替的时间间隔，可用weekly、monthly、yearly或daily
                        rotate 5        #需要保留的旧的日志归档数量
                create 0600 root root
                }
EOF

}
#判断是否存在日志文件，如果没有则创建
if [ ! -f "$url$name" ]
then
	touch "$url$name"
	chmod 777 "$url$name"
fi

#判断是否存在日志轮替的配置文件，没有则创建
if [ ! -f "$config_url$config_name" ]
then
	touch "$config_url$config_name"
	chmod 777 "$config_url$config_name"
fi

config
