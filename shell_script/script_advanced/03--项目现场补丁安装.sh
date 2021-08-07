#!/bin/bash
#脚本功能：一次给系统安装多种类型的补丁，并可以附带上其他操作
#脚本思路：封装多个函数，每个函数对应一个补丁的升级，定义的函数可以在后面随意调用
#使用方法：执行脚本后，会罗列出相应的选项，根据自己需要可以单独就某一个方面做补丁改动。函数体内的内容可以自行修改
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

#给系统升级SP1补丁
function sp1()
{
read -p"是否要升级SP1补丁,回复yes或者no:" g
if [ $g = yes ] || [ $g = y ]
then
        cd 1207-X7-SP1
        chmod +x NeoKylin-Server-5.0_U3-loongson-Release-Build14-X7-SP1-20200810.run
        ./NeoKylin-Server-5.0_U3-loongson-Release-Build14-X7-SP1-20200810.run
        for i in {1..10}
        do
                echo "你已经成功的升级了SP1补丁"
        done
        cd ..
else
        echo "你跳过了安装SP1补丁的操作!!!"
fi
}

#给系统去掉未授权
function authorize()
{
read -p"是否决定去掉系统未授权？回复yes或者no:" f
if [ $f = yes ] || [ $f = y ]
then
        cd NeoKylin_tt
        chmod +x NeoKylin-Server-5.0_U3-loongson_64-Release-B14-12X7_XYC_Activate-20200819.run
        ./NeoKylin-Server-5.0_U3-loongson_64-Release-B14-12X7_XYC_Activate-20200819.run
        for i in {1..10}
        do
                echo "你已经成功的把系统未授权信息给去除"
        done
        cd ..
else
        echo "你跳过了去掉系统未授权这一步操作!!!"
fi
}

#将有关lightdm-gtk的两个包降级
function lightdm()
{
read -p"是否确定要降级lightdm,回复yes或者no:" h
if [ $h = yes ] || [ $h = y ]
then
        cd lightdm-gtk
        rpm -Uvh lightdm-gtk-* --oldpackage
        rpm -qa | grep lightdm-gtk
        cd ..
else
        rpm -qa | grep lightdm-gtk
fi
}

#提醒把系统休眠相关的状态全部清除
function warn()
{
for i in {1..10}
do
        echo "记得检查系统，关闭一切休眠待机状态!"
done
}

#安装中标普华办公软件
function office()
{
read -p"是否确定要卸载旧的中标普华office并安装最新版的中标普华?" l
if [ $l = yes ] || [ $l = y ]
then
        yum remove neoshineoffice*
        cd zh-CN/neoshineoffice/data
        rpm -ivh *.rpm
        cd ../../../
        cp -r zh-CN/neoshineoffice/icons/libswofdsdk.so /usr/lib/
else
        echo "你跳过了安装最新版中标普华的步骤"
fi
}


j=${j:=0}
while [ $j != "exit" ]
do
        echo -e '\n有以下内容可以实现，请看清楚后决定选择哪项执行！'
        echo "1、修改系统时间"
        echo "2、升级系统SP1补丁包"
        echo "3、给系统去掉未授权"
        echo "4、给lightdm降级"
        echo "5、安装中标普华office"
        echo -e '如果需要退出脚本请输入exit'

        read -p"请输入你想要执行的步骤(只输入数字编号):" k
        echo -e '\n'
        if [ $k = 1 ]
        then
                changetime
        elif [ $k = 2 ]
        then
                sp1
        elif [ $k = 3 ]
        then
                authorize
        elif [ $k = 4 ]
        then
                lightdm
        elif [ $k = 5 ]
        then
                office
        else
                echo "你没有输入任何数字"
        fi
        j=$k
done

sp1
authorize
lightdm
office
warn
