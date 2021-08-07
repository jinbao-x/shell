#!/bin/bash
#脚本功能：将文件做成iso
#脚本思路：无
#使用方法：按提示输入
#使用环境：不限
#脚本编写：徐金宝--国防事业本部

read -p"输入需要做成iso的源文件：" SourceDir
Num=`ls -a | grep $SourceDir | wc -l`
if [ $Num == 0 ]
then
	echo -e "不存在此文件！\n"
	exit
fi
read -p"输入需要生成的iso名称：" Name
sudo mkisofs -r -o $Name.iso $SourceDir
<< EOF
基本参数：
-o	设置输出文件名
-V	设置Volume ID
-v	verbose
-m	排除某目录或文件（其不会放入映像文件中）
启动光盘参数：
-b	指定在制作启动光盘时所需的开机映像文件
-J	生成Joliet格式信息（能在windows环境下使用）
-R	能在Unix/Linux环境下使用，文件名区分大小写，同时记录文件长度
其他参数：
-hide	使指定的目录或文件在ISO 9660或Rock RidgeExtensions系统中隐藏
-hide-joliet	使指定的目录或文件在Joliet系统中隐藏
-O	采用MD5空间优化
-C<盘区编号>	将许多节区合成一个映像文件时，使用此参数
-l	允许长文件名
-relaxed-filenames	扩展的文件名
-gbk4dos-filenames	DOS下支持中文
-gbk4win-filenames	WIN下支持中文
EOF
