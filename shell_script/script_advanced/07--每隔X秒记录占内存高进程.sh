#!/bin/bash
#脚本功能：该脚本可以每隔一段时间记录一次占内存高的进程写在日志里
#脚本思路：使用ps查进程并跟管道进行过滤，只统计占的高的前40个进程，里边使用了死循环，目的就是记录内存变化规律
#使用方法：可以执行此脚本并加&符号，放在后台执行，另开一个终端输入tail -f /var/log/memory_percent查看这个日志里最新追加的信息
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

while :
do
        ps auxw | head -1 | >> /var/log/memory_percent
        ps auxw | sort -rn -k4 | head -40 >> /var/log/memory_percent
        echo -e "\n" >> /var/log/memory_percent
        echo -e "\n" >> /var/log/memory_percent
        echo -e "\n" >> /var/log/memory_percent
        sleep 10
done
