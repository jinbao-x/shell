#!/bin/bash
#脚本功能：实现批量建立机器间免密
#脚本思路：使用expect自动处理交互
#使用方法：注意修改用户名、密码，以及把确认能ping通的ip写在数组里，跑脚本前，本机先用ssh-keygen生成pub公钥
#使用环境：确保每台机器用户名以及密码相同，保证要建立免密的ip地址是能ping的通的，可利用另一批量pingIP的脚本先测试互通性
#脚本编写：徐金宝--国防事业本部

front="172.25.90."		#ip地址前三段
array_ip=(102 104 105) 		#ip地址最后一段
user="xu"
password="123123"
for i in ${array_ip[*]}
do
	expect << EOF
		set timeout 120
		spawn ssh-copy-id -i $user@$front$i
		expect {
			"yes/no" {send "yes\n; exp_continue"}
			"password" {send "$password\n; exp_continue"}
		}	
		expect eof
EOF
done
