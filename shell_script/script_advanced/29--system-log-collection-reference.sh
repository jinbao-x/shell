#!/bin/sh
# Copyright (C), 2020, ChangSha JingJia Micro Electronics Co., Ltd.
# this script is used to collect system log for JM7200
# 此脚本来自于716所的一位同事之手，是用来收集景嘉微驱动以及其他一系列相关信息的脚本，见脚本写的很有借鉴意义，便要了一份过来，可以在写脚本的时候参考此脚本里的某些部分

# set -x

if [ -z ${DISPLAY} ]; then
	# echo "DISPLAY is null, set DISPLAY=:0"
	export DISPLAY=:0
fi

# 当前目录
CURDIR=`pwd`

# 当前系统时间
YMD=`LANG=en date "+%Y%m%d%H%M%S"`
# 创建存放系统信息的临时目录
LOGNAME=system-log-${YMD}
LOGHOME=/tmp/${LOGNAME}
sudo rm -rf ${LOGHOME}
mkdir -pv $LOGHOME > /dev/null 2>&1
sync

# dpkg、rpm命令
DPKG=`which dpkg 2>/dev/null`
RPM=`which rpm 2>/dev/null`
IMPORTCMD=`which import`

############# 获取mwv206软件包的二进制文件信息 #############
get_mwv206_file_info() {
# mwv206内核驱动文件
sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' > kernel_mwv206_ko.txt

echo "--------------------------------------------------" >> kernel_mwv206_ko.txt
echo "sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs md5sum" >> kernel_mwv206_ko.txt
sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs md5sum >> kernel_mwv206_ko.txt

echo "--------------------------------------------------" >> kernel_mwv206_ko.txt
echo "sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs ls -l" >> kernel_mwv206_ko.txt
sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs ls -l >> kernel_mwv206_ko.txt

echo "--------------------------------------------------" >> kernel_mwv206_ko.txt
echo "sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs -i nm {} " >> kernel_mwv206_ko.txt
sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs -i nm {} >> kernel_mwv206_ko.txt

echo "--------------------------------------------------" >> kernel_mwv206_ko.txt
echo "sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs strings" >> kernel_mwv206_ko.txt
sudo find  /lib/modules/`uname -r`/  -name '*mwv206*' | xargs -i strings {} >> kernel_mwv206_ko.txt



# mwv206核外驱动文件
ls -l  /usr/lib/*-linux-gnu*/  | grep -i mwv206 >> usr_lib_xorg_mwv206_so.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_xorg_mwv206_so.txt
ls -l  /usr/lib/*-linux-gnu*/libGL*.so* >> usr_lib_xorg_mwv206_so.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_xorg_mwv206_so.txt

sudo find  /usr/lib*/xorg/modules/ -name '*mwv206*' 2>/dev/null | xargs  ls -l >> usr_lib_xorg_mwv206_so.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_xorg_mwv206_so.txt
sudo find  /usr/lib*/xorg/modules/ -name '*mwv206*' 2>/dev/null | xargs  md5sum >> usr_lib_xorg_mwv206_so.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_xorg_mwv206_so.txt
sudo find  /usr/lib*/xorg/modules/ -name '*mwv206*' 2>/dev/null | xargs  strings >> usr_lib_xorg_mwv206_so.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt

sudo find  /usr/lib/*-linux-gnu*/  -maxdepth  1 -type f | grep -i mwv206 | xargs ls -l >> usr_lib_arch_mwv206_files.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
sudo find  /usr/lib/*-linux-gnu*/  -maxdepth  1 -type f | grep -i mwv206 | xargs -i ldd {} >> usr_lib_arch_mwv206_files.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
sudo find  /usr/lib/*-linux-gnu*/  -maxdepth  1 -type f | grep -i mwv206 | xargs md5sum >> usr_lib_arch_mwv206_files.txt 2>/dev/null
sudo find  /usr/lib/*-linux-gnu*/  -maxdepth  1 -type f | grep -i mwv206 | xargs -i strings {} >> usr_lib_arch_mwv206_files.txt 2>/dev/null
echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt

if [ ! -z $DPKG ]; then
    sudo find  /usr/lib/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs  ls -l >> usr_lib_arch_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
    sudo find  /usr/lib/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs -i ldd {} >> usr_lib_arch_mwv206_files.txt
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
    sudo find  /usr/lib/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs  md5sum >> usr_lib_arch_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
    sudo find  /usr/lib/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs -i strings {} >> usr_lib_arch_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
fi

if [ ! -z $RPM ]; then
    sudo find  /usr/lib64/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs  ls -l >> usr_lib_arch_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
    sudo find  /usr/lib64/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs -i ldd {} >> usr_lib_arch_mwv206_files.txt
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
    sudo find  /usr/lib64/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs  md5sum >> usr_lib_arch_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
    sudo find  /usr/lib64/*-linux-gnu*/mwv206/ -type f  2>/dev/null | xargs -i strings {} >> usr_lib_arch_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_arch_mwv206_files.txt
fi

if [ ! -z $RPM ]; then
    sudo find /usr/lib*/mwv206/ -type f 2>/dev/null | xargs ls -l >> usr_lib_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_mwv206_files.txt
    sudo find /usr/lib*/mwv206/ -type f 2>/dev/null | xargs -i ldd {} >> usr_lib_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_mwv206_files.txt
    sudo find /usr/lib*/mwv206/ -type f 2>/dev/null | xargs md5sum >> usr_lib_mwv206_files.txt 2>/dev/null
    echo "--------------------------------------------------" >> usr_lib_mwv206_files.txt
    sudo find /usr/lib*/mwv206/ -type f 2>/dev/null | xargs -i strings {} >> usr_lib_mwv206_files.txt 2>/dev/null
fi

}


#############
# 进入收集系统日志的临时目录
cd $LOGHOME
############# 获取系统信息 #############
# 当前内核日志
sudo dmesg > dmesg.log.txt

# 完整内核日志
if [ -e /var/log/kern.log ]; then
  sudo cp /var/log/kern.log .
fi

# 完整的syslog日志
if [ -e /var/log/syslog ]; then
  sudo cp /var/log/syslog .
fi

# Xorg日志文件
if [ -e /var/log/Xorg.0.log ]; then
  sudo cp /var/log/Xorg.0.log* .
fi


# JM7200 显卡的PCI信息
sudo lspci -d 0731:7200 -vvv > lspci-7200.txt

# 完整的PCI信息
sudo lspci -vvv > lspci.txt 2>/dev/null

# 当前CPU信息
sudo lscpu >> lscpu.txt

# JM7200 显卡信息
if [ -e /proc/gpuinfo_0 ]; then
cat /proc/gpuinfo_0 > gpuinfo_0.txt
fi
if [ -e /proc/gpuinfo_1 ]; then
cat /proc/gpuinfo_1 > gpuinfo_1.txt
fi

# 当前内存使用情况
free -m >> free.txt

# 当前进程信息
ps auxf > ps.auxf.txt

# xrandr信息
xrandr > xrandr.txt
echo "-----------------------------------" >> xrandr.txt
xrandr --verbose >> xrandr.txt

# 系统安装的软件包信息
if [ ! -z $DPKG ]; then
	dpkg -l >> dpkg-all.txt
	dpkg -l | grep mwv206 | awk '{ print $2 }' | xargs -i dpkg -s {} > dpkg-mwv206.txt
	echo "---------------------" >> dpkg-mwv206.txt
	
	FLS=`dpkg -l | grep mwv206 | awk '{ print $2 }' | xargs -i dpkg -L {} | xargs -i  echo {}`
	for FL in $FLS
	do
	   if [ -f $FL ]; then
	     ls -l $FL >> dpkg-mwv206.txt
	     md5sum $FL >> dpkg-mwv206.txt
	   fi
	done
fi
if [ ! -z $RPM ]; then
	rpm -qa >> rpm-qa.txt
	rpm -qa | grep mwv206 | awk '{ print $1 }' | xargs -i rpm -qi {} > rpm-mwv206.txt
	echo "---------------------" >> rpm-mwv206.txt
	FLS=`rpm -qa | grep mwv206 | awk '{ print $1 }' | xargs -i rpm -ql {}`
	for FL in $FLS
	do
	    if [ -f $FL ]; then
	      ls -l $FL >> rpm-mwv206.txt
	      md5sum $FL >> rpm-mwv206.txt
	    fi
	done
	
fi

# 当前内核版本信息
uname -a > uname-a.txt
echo "\n\n\n" >> uname-a.txt
# 内核启动参数
cat /proc/cmdline >> uname-a.txt

# 当前系统版本信息
if [ -e /etc/lsb-release ]; then
	cp /etc/lsb-release .
fi
if [ -e /etc/os-release ]; then
	cp /etc/os-release .
fi

# 获取mwv206软件包相关的信息
get_mwv206_file_info
sync

# 当前进程占用CPU情况
top -n 2 > top.txt

if [ ! -z ${IMPORTCMD} ]; then
    ${IMPORTCMD} -window root screen-import.png
fi


# 可以在此处添加新的系统信息收集命令


############# 获取系统信息 #############
sudo chmod -R 0777 ${LOGHOME}
cd /tmp/
sync
tar czf ~/${LOGNAME}.tgz ${LOGNAME}
sync
cd $CURDIR

echo "收集收集系统日志成功，日志文件位于 ~/${LOGNAME}.tgz "
# echo "System Log File ~/${LOGNAME}.tgz"

<< EOF 
使用方法
  ./system-log-collection.sh
  执行该命令的要求当前用户拥有sudo执行权限，执行时会提示输入当前用户执行sudo时的密码。
  执行成功后会提示"收集收集系统日志成功，日志文件位于 ~/system-log-20200525.tgz"，将该文件导出即可。

system-log-yyyymmdd.tgz 文件包括如下系统日志文件
dmesg.log.txt                 : 当前内核日志
dpkg-all.txt                  : 系统安装的软件包信息
rpm-qa.txt                    : 系统安装的软件包信息
free.txt                      : 当前内存使用情况
gpuinfo_0.txt                 : JM7200 显卡信息
gpuinfo_1.txt                 : JM7200 显卡信息
kern.log                      : 完整内核日志
lsb-release                   : 当前系统版本信息
os-release                    : 当前系统版本信息
lscpu.txt                     : 当前CPU信息
lspci-7200.txt                : JM7200 显卡的PCI信息
lspci.txt                     : 整的PCI信息
ps.auxf.txt                   : 当前进程信息
syslog                        : 完整的syslog日志
uname-a.txt                   : 当前内核版本信息
Xorg.0.log                    : Xorg日志文件
Xorg.0.log.old                : Xorg日志文件
xrandr.txt                    : xrandr信息
kernel_mwv206_ko              : mwv206内核ko文件信息
usr_lib_arch_mwv206_files.txt : /usr/lib/*-linux-gnu*/mwv206/目录下的mwv206驱动文件信息
usr_lib_mwv206_files.txt      : /usr/lib*/mwv206/目录下的mwv206驱动文件信息
usr_lib_xorg_mwv206_so.txt    : /usr/lib*/xorg/modules/目录下的mwv206驱动文件信息
top.txt                       : 当前进程占用CPU情况
screen-import.png             : 保存当前截屏图片（ssh登录执行，将是黑屏图片）
EOF
