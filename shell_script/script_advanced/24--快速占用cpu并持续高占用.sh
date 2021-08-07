#!/bin/bash
#脚本功能：快速占用cpu，用作测试
#脚本思路：使用cat，将无限大重定向到黑洞
#使用方法：需要输入整数，以便拉起n个占cpu的进程
#使用环境：R系
#脚本编写：徐金宝--国防事业本部

function high_cpu()
{
cat /dev/zero > /dev/null
}

read -p"确认需要几个占cpu的进程？ " a
for i in ((i=0;i<"$a";i++))
do
	high_cpu &
done
