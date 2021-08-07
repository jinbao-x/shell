#!/bin/bash
#脚本功能：判断IP是否合法
#脚本思路：使用awk以.分隔，判断每个部分的数字是否在255范围内
#使用方法：函数体内判断的是$IP，因此用这个函数的前提是有IP这个变量
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

IP=192.168.0.100
function isIP()
{
	Num=`echo $IP | awk -F. '{ print NF }'`
	No1=`echo $IP | awk -F. '{ print $1 }'`
	No2=`echo $IP | awk -F. '{ print $2 }'`
	No3=`echo $IP | awk -F. '{ print $3 }'`
	No4=`echo $IP | awk -F. '{ print $4 }'`
	if [ $Num != 4 ] || [ $No1 -gt 255 -o $No1 -lt 1 ] || [ $No2 -gt 255 -o $No2 -lt 0 ] || [ $No3 -gt 255 -o $No3 -lt 0 ] || [ $No4 -gt 255 -o $No4 -lt 0 ]
	then
		echo "IP不合法"
		return 1
	fi
}
isIP
echo $?
