#!/bin/bash
#脚本功能：一键配置本地yum源
#脚本思路：该脚本会自动检测挂载，然后在挂载路径下搜寻repodata的路径，将其父路径设置为temp.repo的url,并展示出基本信息和包数量
#使用方法：非交互式脚本。使用时如果自动识别的挂载路径有问题时，此脚本便不可运行
#使用环境：R系操作系统
#脚本编写：徐金宝--国防事业本部

URL=/etc/yum.repos.d/

if [ $# == 0 ]
then
        a=`lsblk | grep sr0 | awk '{print $7}'`
        ls $a &> /dev/null
        if [ $? -eq 0 ]
        then
                b=`find $a -name repodata`
                c=`echo $b | awk -F '/repodata' '{print $1}'`
                mkdir $URL/bak
                mv $URL/*.repo /$URL/bak
                touch $URL/temp.repo
                echo '[temp]' > $URL/temp.repo
                echo 'name=temp' >> $URL/temp.repo
                echo "baseurl=file://$c" >> $URL/temp.repo
                echo "gpgcheck=0" >> $URL/temp.repo
                echo "enabled=1" >> $URL/temp.repo
                yum clean all
                yum makecache
                yum repolist
        else
                echo "自动识别到路径$a，但是此路径似乎有问题，请检查一下！"
        fi
else
        ls "$1" &> /dev/null
        if [ $? == 0 ]
        then
                mkdir $URL/bak
                mv $URL/*.repo /$URL/bak
                touch $URL/temp.repo
                echo '[temp]' > $URL/temp.repo
                echo 'name=temp' >> $URL/temp.repo
                echo "baseurl=file://'$1'" >> $URL/temp.repo
                echo "gpgcheck=0" >> $URL/temp.repo
                echo "enabled=1" >> $URL/temp.repo
                yum clean all
                yum makecache
                yum repolist
        else
                echo "运行脚本时，添加的yum源路径不存在"
        fi
fi
