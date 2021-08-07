#!/bin/bash
#脚本功能：关机测试脚本
#脚本思路：
#使用方法：配合其他几个脚本使用，45--LongTestTools.sh这个脚本已经把另外的这些脚本整合起来了，所以最终执行时应该使用45
#使用环境：V10-desktop不要改这些脚本的名字

usrname=`cat /var/tmp/LogNames`;
total=`cat /var/tmp/LogBootNo`;
Timeout=30;
timeall=$(($Timeout*10))
if [ ! -e /etc/xdg/autostart/BootTest.desktop ] ; then
        echo -e  "[Desktop Entry]\nEncoding=UTF-8\nName=RebootTest\nType=Application\nExec=44--BootTest.sh --autostart\nTerminal=false\nType=Application\nX-UKUI-AutoRestart=true\nOnlyShowIn=UKUI\nX-UKUI-Autostart-Phase=Application\nNoDisplay=true">/etc/xdg/autostart/BootTest.desktop;
        chmod 666 /etc/xdg/autostart/BootTest.desktop;
fi

if [ ! -e /var/tmp/logBootTest ] ;then
        echo "0" > /var/tmp/logBootTest
        chmod 666 /var/tmp/logBootTest;
fi
var=`cat /var/tmp/logBootTest`
if [ $var -eq $total ]; then
        echo "0" > /var/tmp/BootFinish.log;zenity --info --text="您已经完成了系统关机测试,系统将重新启动以恢复设置";
        #echo "0" > /etc/xdg/autostart/BootTest.desktop;
        echo "0" > /var/tmp/logBootTest;
        echo "0" > /var/tmp/LogBootNo;
        reboot;
        exit ;
fi
if [ $var -gt $total ]; then
        echo "0">/var/tmp/logBootTest;
        var=`cat /var/tmp/logBootTest`;
fi
let Addvar=$var+1;
if [ $var -le $total ]; then
        for ((i=10;i<=100; ));do
                let Timeout=$Timeout-1;
                echo $i;
                echo "#共关机测试$total次,当前关机第$Addvar次.$Timeout秒后关机.";
                sleep 1;
                let i=$i+10;
        done | zenity --progress  --auto-close ;
        if [ `echo "$?"` -ne 0 ]; then
                echo "0" > /var/tmp/BootCancel.log; zenity --info --text="您取消了系统关机测试,系统将重新启动以恢复设置";
                echo "0" > /var/tmp/logBootTest;
                echo "0" > /var/tmp/LogBootNo;
                reboot;
                exit;
        fi
        echo $Addvar > /var/tmp/logBootTest;
        echo "+60"> /sys/class/rtc/rtc0/wakealarm;
        halt
fi
