#!/bin/bash
#脚本功能：重置重启脚本改变的环境
#脚本思路：移除desktop、日志文件以及恢复其他相关状态
#使用方法：配合其他几个脚本使用，45--LongTestTools.sh这个脚本已经把另外的这些脚本整合起来了，所以最终执行时应该使用45
#使用环境：V10-desktop不要改这些脚本的名字

usrname=`cat /var/tmp/LogNames`;

if [ -e /var/tmp/Rebootfinish.log ] ;then
        rm -rf  /etc/xdg/autostart/RebootTest.desktop
        rm -rf /etc/lightdm/lightdm.conf
        mv /var/tmp/LogRebootTest /var/tmp/LogRebootTest-`date +'%Y-m-%d-%Hh%Mm%Ss'`
        mv /var/tmp/LogRebootNo /var/tmp/LogRebootNo-`date +'%Y-%m-%d-%Hh%Mm%Ss'`
        rm -rf /var/tmp/Rebootfinish.log
        rm -rf /var/tmp/LogNames
        sed -i '/\/usr\/sbin\/46--RebootReplace.sh/d' /etc/rc.local
        sed -i '/exit 0/d' /etc/rc.local

fi
if [ -e /var/tmp/RebootCancel.log ] ;then
        rm -rf  /etc/xdg/autostart/RebootTest.desktop
        rm -rf /etc/lightdm/lightdm.conf
        mv /var/tmp/LogRebootTest /var/tmp/LogRebootTest-`date +'%Y-%m-%d-%Hh%Mm%Ss'`
        mv /var/tmp/LogRebootNo /var/tmp/LogRebootNo-`date +'%Y-%m-%d-%Hh%Mm%Ss'`
        rm -rf /var/tmp/RebootCancel.log
        rm -rf /var/tmp/LogNames

        sed -i '/\/usr\/sbin\/46--RebootReplace.sh/d' /etc/rc.local
        sed -i '/exit 0/d' /etc/rc.local
fi

