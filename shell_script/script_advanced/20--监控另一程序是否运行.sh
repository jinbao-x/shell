#!/bin/bash
#脚本功能：判断另一个程序是否运行，开始运行时和结束运行时打印日志到messages里
#脚本思路：最外层循环是死循环，然后判断另一程序开始运行时，打印开始日志，然后就开始内循环判断另一程序是否结束，直到结束时结束内循环，然后打印结束日志
#使用方法：使用之前把脚本前面的几个变量值修改一下，分别是循环检测的时间间隔、程序名称、开始时往messages输出的日志、结束时往messages输出的日志。此脚本添加到rc.local一直运行
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

time_span=1
name="nnn"
log_begin="xxx"
log_end="yyy"
while :
do
        b=`ps -aux | grep $name | grep -v grep | wc -l`
        if [ $b != 0 ]
        then
                logger "$log_begin"
                echo "begin"
                c=1
                until [ "$c" == 0 ]
                do
                        c=`ps -aux | grep $name | grep -v grep | wc -l`
                        sleep $time_span
                done
                logger "$log_end"
                echo "end"
        fi
        sleep $time_span
done
