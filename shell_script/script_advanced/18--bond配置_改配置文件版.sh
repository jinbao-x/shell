#!/bin/bash
#脚本功能：修改配置文件的方法给双网卡做bond绑定
#脚本思路：交互式等待输入网卡名等信息，对输入信息做匹配判断输入的网卡是否存在，存在的话，则根据名称在配置文件指定行添加做bond的配置信息
#关于bond0的配置写到了函数中，在后面会调用这个函数，如果已经有了bond0配置文件，则会直接调用函数刷新bond0的配置信息，如果没有bond0文件，则会先创建bond0文件，然后再调用函数写入配置信息
#使用方法：请务必保证两个网卡都能连上网，否则脚本跑完后输出的信息，会提示up状态的slave个数为0。请务必保证运行脚本时输入正确的配置值
#使用环境：不限，此脚本前几行会禁用NetworkManager，根据情况决定是否禁用它，不用则注释
#脚本编写：徐金宝--国防事业本部

NET=/etc/sysconfig/network-scripts/
systemctl stop NetworkManager
systemctl disable NetworkManager
read -p"请输入添加到bond的第一张网卡名称：" a
A=`ifconfig | grep $a | wc -l`
if [ $A != 0 ]
then
        ls "$NET"ifcfg-"$a" &> /dev/null
        if [ $? != 0 ]
        then
                echo "我找不到网卡$a的配置文件，请确认你添加的第一张网卡名称是否正确"
        else
                M=`cat "$NET"ifcfg-"$a" | grep "SLAVE=" | wc -l`
		if [ $M != 0 ]
		then
			sed -i '/SLAVE=/s/.\+/SLAVE=yes/' "$NET"ifcfg-"$a"
		else
			sed -i '/DEVICE=\"'"$a"'\"/ a\MASTER=bond0\nSLAVE=yes' "$NET"ifcfg-"$a"
		fi
        fi
else
        echo "没有名称为$a的网卡"
fi

read -p"请输入添加到bond的第二张网卡名称：" b
B=`ifconfig | grep $b | wc -l`
if [ $B != 0 ]
then
        ls "$NET"ifcfg-"$b" &> /dev/null
        if [ $? != 0 ]
        then
                echo "我找不到网卡$b的配置文件，请确认你添加的第二张网卡名称是否正确"
        else
                N=`cat "$NET"ifcfg-"$b" | grep "SLAVE=" | wc -l`
		if [ $N != 0 ]
		then
			sed -i '/SLAVE=/s/.\+/SLAVE=yes/' "$NET"ifcfg-"$b"
		else
			sed -i '/DEVICE=\"'"$b"'\"/ a\MASTER=bond0\nSLAVE=yes' "$NET"ifcfg-"$b"
		fi
        fi
else
        echo "没有名称为$b的网卡"
fi


function bond(){
	read -p"请输入bond需要配置的IP：" ip
	read -p"请输入IP的掩码位数：" prefix
	read -p"请输入bond需要配置的网关：" gateway
	cat << EOF > "$NET"ifcfg-bond0
	TYPE=Bond
	ONBOOT=yes
	DEVICE=bond0
	BONDING_MASTER=yes
	IPADDR=$ip
	PREFIX=$prefix
	GATEWAY=$gateway
	BOOTPROTO=none
	USERCTL=no
	BONDING_OPTS="mode=1 miimon=100"
EOF
}

if [ -f "$NET"ifcfg-bond0 ]
then
	bond
else
	touch "$NET"ifcfg-bond0
	bond
fi

systemctl restart network
ifconfig | grep bond0 -A 7
cat /proc/net/bonding/bond0
