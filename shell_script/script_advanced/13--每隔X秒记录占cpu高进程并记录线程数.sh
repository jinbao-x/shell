#!/bin/bash
#脚本功能：每15秒记录一次占cpu前30的进程，并把每个进程对应的线程数量在末列显示，终端会输出结果，并另保存每次的结果记录到/var/log/cpu_percent中
#脚本思路：循环体里使用ps auxw查进程，并配合sort以及grep工具筛选前30个进程，使用awk提取PID，根据PID进一步查线程数量，线程数量提取后，与前面进程信息组合在一起，并将空格换为制表符，让输出结果简洁一些
#使用方法：可以执行此脚本并加&符号，放在后台执行，执行完之后可以ps -aux | grep name查一下这个脚本进程有没有确实在后台运行,以及开一个终端输入tail -f /var/log/cpu_percent查看这个日志里最新追加的信息
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

while [ 1 == 1 ]
do
        d=`ps -auxw | head -1`
        echo $d | sed 's/ /\t\t/' | sed 's/ /\t/' | sed 's/ /\t/' | sed 's/ /\t/' | sed 's/ /\t/'| sed 's/ /\t/' | sed 's/ /\t/'| sed 's/ /\t/' >>  /var/log/cpu_percent
        for i in `ps auxw |sort -rn -k3 | grep -v PID | head -30 | awk '{print $2}'`
        do
                a=`ps auxw | grep -v grep | grep $i | awk '{if($2=="'$i'")print $0}'`
                b=`pstree -p $i | wc -l`
                c="$a -->  $b"
                echo $c | sed 's/ /\t\t/' | sed 's/ /\t/' | sed 's/ /\t/' | sed 's/ /\t/' | sed 's/ /\t/'| sed 's/ /\t/' | sed 's/ /\t/'| sed 's/ /\t/' >>  /var/log/cpu_percent
        done
        echo -e "\n" >> /var/log/cpu_percent
        echo -e "\n" >> /var/log/cpu_percent
        echo -e "\n" >> /var/log/cpu_percent
        sleep 10
done


#这个脚本用的pstree查的线程，其实也可用通过查proc下对应文件的方式找出来线程数，脚本很早写的，实在懒得修改了，以后再说吧
