#!/bin/bash 
#脚本功能：监控进程打开文件数以及对应线程数
#脚本思路：使用了lsof工具，以及通过直接统计proc/task/下的文件统计线程数
#使用方法：终端或后台运行
#使用环境：不限
#脚本编写：彭雁--国防支持总经理

echo > /tmp/test.log		#每次执行脚本先清空临时日志文件以便弄混

#遍历所有进程号，统计这些进程对应的打开文件数量以及线程总数，只有文件数量大于500或线程数量大于10的进程信息会进行记录
for i in `ls /proc| grep ^[0-9]`
do
    num=$(lsof -a -p $i 2>/dev/null |wc -l)
    threadnum=$(ls /proc/$i/task 2>/dev/null|wc -l)
    if [ $num -gt 500 -o  $threadnum -gt 10  ]
    then
    	comm=`cat /proc/$i/comm`
    	echo "$i $threadnum $num $comm" >> /tmp/test.log	#echo"pid 线程总数 该pid进程打开的文件数 进程名称"到临时日志文件
    fi
done

sleep 1

#下面开始读存好的信息
echo "pid thread_num file_num name"	#echo标题行

echo "文件数量大于500"
cat /tmp/test.log|awk '$3>500{print $0}'|sort -r -k 3 -n	#用awk打印出每行内容,用sort进行排序(-n按数字排序、-r逆序、-k 3按第三域进行排序)
echo "线程数量大于10"
cat /tmp/test.log|awk '$2>10{print $0}'|sort -r -k 2 -n

sleep 1

echo > /tmp/test.log			#清空临时日志文件

<< EOF
补充：
lsof(lists openfiles)其非常的全能，甚至能做netstat和ps的全部工作
可以使用lsof获得系统上设备的信息，能了解到指定的用户在指定的地点正在碰什么东西
当传递参数时，默认行为是对结果进行"或"运算。因此如果你用-i拉出一个端口列表的同时又用-p拉出进程列表，那么默认会得到两个的结果
-a	让结果进行"与"运算
-l	在输出显示用户ID而不是用户名
-t	仅获取进程ID
-U	获取UNIX套接口地址
-F	格式化输出结果，用于其他命令，可以通过多种方式格式化，如-F pcfn(用于进程id、命令名、文件描述符、文件名、并以空终止)
-p	查看制定进程ID已打开的内容

/proc/pid/下的一些信息:
/proc/pid/comm		应用程序或命令名字
/proc/pid/task/		此目录下是对应的线程信息
EOF
