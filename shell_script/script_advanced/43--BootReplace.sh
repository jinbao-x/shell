#!/bin/bash
#脚本功能：恢复其他关机测试脚本执行后所带来的改动
#脚本思路：移除desktop、日志文件以及恢复其他相关状态
#使用方法：配合其他几个脚本使用，45--LongTestTools.sh这个脚本已经把另外的这些脚本整合起来了，所以最终执行时应该使用45
#使用环境：V10-desktop不要改这些脚本的名字

usrname=`cat /var/tmp/LogNames`;
if [ `cat /var/tmp/BootFinish.log` -eq 0  ]; then
        rm -rf  /etc/xdg/autostart/BootTest.desktop;
        rm -rf /etc/lightdm/lightdm.conf
        rm -f /var/tmp/BootFinish.log;
        mv /var/tmp/LogBootTest /var/tmp/LogBootTest-`date +'%Y-m-%d-%Hh%Mm%Ss'`
        mv /var/tmp/LogBootNo /var/tmp/LogBootNo-`date +'%Y-%m-%d-%Hh%Mm%Ss'`
        rm -rf /var/tmp/Bootfinish.log
        rm -rf /var/tmp/LogNames
        sed -i '/\/usr\/sbin\/43--BootReplace.sh/d' /etc/rc.local
        sed -i '/exit 0/d' /etc/rc.local
fi
if  [ `cat /var/tmp/BootCancel.log ` -eq 0 ] ;then
        rm -rf  /etc/xdg/autostart/BootTest.desktop;
        rm -rf /etc/lightdm/lightdm.conf
        rm -f /var/tmp/BootFinish.log;
        mv /var/tmp/LogBootTest /var/tmp/LogBootTest-`date +'%Y-m-%d-%Hh%Mm%Ss'`
        mv /var/tmp/LogBootNo /var/tmp/LogBootNo-`date +'%Y-%m-%d-%Hh%Mm%Ss'`
        rm -rf /var/tmp/Bootfinish.log
        rm -rf /var/tmp/LogNames
        sed -i '/\/usr\/sbin\/43--BootReplace.sh/d' /etc/rc.local
        sed -i '/exit 0/d' /etc/rc.local
fi
