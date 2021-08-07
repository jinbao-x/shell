#!/bin/bash
#脚本功能：循环pingIP
#脚本思路：嵌套循环，i和j分别是IP的第三位和第四位，以及修改一下默认的前两位
#使用方法：用前先修改脚本内的{}内的IP范围
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

iping(){
        ping -c5 -i0.5 -w5 $1 &> /dev/null
        if [ $? -eq 0 ]
        then
                echo "$IP is up"
        else
                sleep 5
                echo "$IP is down"
        fi
}


for i in {60..60}
do
        for j in {60..90}
        do
                IP="192.168.$i.$j"
                iping $IP &
        done
done
