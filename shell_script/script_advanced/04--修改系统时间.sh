#!/bin/bash
#脚本功能：给系统修改日期和时间，此脚本可以添加在其他对时间有要求的脚本前面（比如系统授权等）
#脚本思路：更改系统日期和时间采用date -s的方式，封装一个函数，后面调用，想怎么用看自己发挥
#使用方法：执行脚本会有read -p提示，然后对应输入相应的信息进行修改
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

#两层if嵌套是判断系统时间是否想要的正确的时间，如果是则往下进行，如果不是则进行相应的时间设置
function changetime()
{
date
read -p"是否确定当前系统时间是正确的，回复yes或者no:" a
if [ $a = yes ] || [ $a = y ]
then
        echo  "现在开始进行其他配置"
else
        echo -e '你判定系统时间并非是自己想要的时间，接下来开始进行修改'
        read -p"日期是正确的吗，如果正确则回复yes，以便直接配置时间，回复其他则将日期与时间>一起修改:" b
        if [ $b = yes ] || [ $b = y ]
        then
                lsl 2> /dev/null
                until [ $? = 0 ]
                do
                        read -p"请输入想要修改的时间，请注意格式为XX:XX:XX   " c
                        date -s $c
                done
                for i in {1..10}
                do
                        date
                done
        else
                lsl 2> /dev/null
                until [ $? = 0 ]
                do
                        read -p"先修改日期，注意日期格式为XXXX/XX/XX   " d
                        date -s $d
                done
                lsl 2> /dev/null
                until [ $? = 0 ]
                do
                        read -p"现在修改时间，注意时间格式为XX:XX:XX   " e
                        date -s $e
                done
                for i in {1..10}
                do
                        date
                done
        fi
fi
}

changetime
