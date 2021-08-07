#!/bin/bash
#脚本功能：循环对IPping，测试IP的连通性
#脚本思路：对IP的ping结果封装到函数里，然后以读取IP列表的值的方式循环，每次循环放到后台
#使用方法：事先需要在同一目录下先创建IP_LIST文件，然后预先添加需要测的IP进去
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

#定义循环pingIP的函数
iping(){
	ping -c5 -i0.5 -W5 $1 &> /dev/null	#这里$1为该iping函数的第一个接收参数
	if [ $? -eq 0 ]
	then
		echo -e "\n"
		echo "$i is up"
	else
		echo -e "\n"
		echo "$i is down"
	fi
}

if [ ! -f IP_LIST ]
then
	echo "请在运行此脚本之前在同一目录下创建IP_LIST文件，并添加IP进去！"
	exit
fi
for i in $(cat IP_LIST)
do
	iping $i &		#此处调用函数iping，这种方式可以使得每次循环都可以放到后台执行，进而迅速进行下一次循环
done
