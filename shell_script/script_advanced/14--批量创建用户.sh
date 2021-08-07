#!/bin/bash
#脚本功能：批量添加用户
#脚本思路：每次运行脚本后，会首先判断是否有USER_LIST文件，如果没有则进行创建，并接收用户输入。读取USER_LIST并进行创建用户的时候会判断每行的用户是否已经存在，如果已经存在则不进行创建，并且会输出这行已经创建过的用户的信息(/etc/passwd)
#使用方法：此脚本是交互脚本
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

if [ ! -f "USER_LIST" ]
then
	touch USER_LIST
	chmod 777 USER_LIST
	a=1
	while [ $a != "exit" ]
	do
		read -p "请输入需要添加的用户(输入exit可结束输入)： " a
		echo $a >> USER_LIST 
	done
	sed -i '/exit/d' USER_LIST	#去掉最后一次循环追加进去的exit
fi
sed -i '/^$/d' USER_LIST	#去掉USER_LIST里的空行

for i in $(cat USER_LIST)
do
	cat /etc/passwd | grep $i
	b=`echo $?`
	if [ $b != 0 ]
	then
		useradd $i
		echo "123123" | passwd --stdin $i
	fi
done
echo "您已经创建了USER_LIST列表里的用户，初始密码为123123"
