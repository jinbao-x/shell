#!/bin/bash
#脚本功能：可以打开多个标签，同时ping多个IP
		#批产车项目有的兵哥哥会希望有此功能，方便提前把一堆要ping的ip在列表里存好，用时直接ping即可
#脚本思路：通过循环，读取IP_list文件里的IP，每有一个IP就打开一个标签并执行ping命令
#使用方法：此脚本所在的目录下，需要有一个IP_LIST文件，文件中按行写入IP，ping时执行脚本即可
#使用环境：系统环境下需要保证mate-terminal可以调出，有的系统环境是gnome-terminal
#脚本编写：徐金宝--国防事业本部

for i in $(cat IP_LIST)
do
	mate-terminal --tab -x bash -c "echo 'ping $i';ping $i;exec bash"
done
