#!/bin/bash
#脚本功能：批量分发文件到其他机器
#脚本思路：使用expect处理交互输入
#使用方式：注意修改脚本前面的变量，设置了超时时间间隔为120秒，脚本完成前，切勿手动干预
#使用环境：使用前确保这些目标ip能ping通，或者已经设置了免密
#脚本编写：徐金宝--国防事业本部

front="172.25.90."	#ip地址前三段
array_ip=(102 104 105)	#ip地址最后一段
user="xu"		
password="123123"
script='/home/test/test.sh'	#本地脚本所在位置，注意写绝对路径，否则脚本不认
dir='~/'		#目标路径
for i in ${array_ip[*]}
do
	expect << EOF
		set timeout 120
		spawn scp -r $script $user@$front$i:$dir
		expect {
			"yes/no" {send "yes\n"; exp_continue}
			"password" {send "$password\n"; exp_continue}
	}
	expect eof
EOF
done
