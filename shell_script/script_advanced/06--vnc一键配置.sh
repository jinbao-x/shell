#!/bin/bash
#脚本功能：该该脚本传远端机器，并在远端运行，可以将vnc打开
#脚本思路：gsettngs设置vino的配置
#使用方法：将该脚本通过scp命令拷贝到远程主机,然后ssh -X root@IP	连接上远程主机，执行这个脚本即可在远程主机完成远程登录的授权
#使用环境：系统版本为kylin-5.0-B014(其他版本是否可用没有测验)
#脚本编写：徐金宝--国防事业本部

/usr/libexec/vino-server &
#export DISPLAY=:0.0

gsettings set org.gnome.Vino enabled true			#允许其他人查看您的桌面->勾选
gsettings set org.gnome.Vino view-only false			#允许其他用户控制您的桌面->勾选
gsettings set org.gnome.Vino prompt-enabled false		#您必须为本机器确认每次访问->取消勾选
gsettings set org.gnome.Vino authentication-methods "['none']"	#要求用户输入此密码->取消勾选
gsettings set org.gnome.Vino icon-visibility "'client'"		#显示通知区域图标->选择只在有用户连接时
#gsettings set org.gnome.Vino icon-visibility "'always'"		#显示通知区域图标->选择总是
#gsettings set org.gnome.Vino icon-visibility "'never'"		#显示通知区域图标->选择从不

#gsettings set org.gnome.Vino authentication-methods "['vnc']" / "['none']"	#需要密码/不需要密码
#gsettings set org.gnome.Vino vnc-password "'MQ=='"		#代表设置的密码

systemctl stop firewalld		#关闭防火墙
systemctl disable firewalld		#关闭防火墙开机自启
