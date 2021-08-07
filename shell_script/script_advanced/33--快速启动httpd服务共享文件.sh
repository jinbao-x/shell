#!/bin/bash
#脚本功能：共享当前目录，其他主机可通过浏览器输入IP:8000的方式访问
#脚本思路：使用python内置的功能
#使用方法：机器A运行脚本会拉起httpd服务，将脚本所在的路径以web的方式共享出去，机器B打开浏览器使用192.168.1.100:8000访问
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

CurDir=`pwd`
Py3=`which python3 | wc -l`
Py2=`which python2 | wc -l`
cd $CurDir
if [ $Py2 == 1 ] && [ $Py3 == 0 ]		#只有在python3解释器不存在且python2存在时使用python2
then
		python2 -m SimpleHTTPServer
else
		python3 -m http.server
fi
