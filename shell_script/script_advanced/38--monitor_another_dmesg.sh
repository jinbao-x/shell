#!/usr/bin/expect -f
#脚本功能：监控另外一台机器的demsg信息
#脚本思路：使用spawn处理交互
#使用方法：注意修改IP
#使用环境：不限
#脚本编写：徐琪琪

IP=172.25.90.50
spawn ssh root@IP
expect {
"*yes/no*" {send "yes\r"; exp_continue}
"*password*" {send "1\r"}
}
expect "#*"
send "dmesg -w\r"
interact

