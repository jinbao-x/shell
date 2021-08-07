#!/bin/bash
#脚本功能：该脚本可以识别到哪个是USB鼠标设备，然后将其禁用（可用作测试）,可以参考这个脚本禁用、启用其他设备
#脚本思路：利用grep过滤，使用awk提取出id号，然后执行命令将其禁用，之所以不直接根据id禁用某设备，是因为插拔设备后id可能会变化，但是设备名一般不变
#使用方法：修改grep后的关键字，确保能“唯一识别”欲禁设备
#使用环境：不限
#脚本编写：徐金宝--国防事业本部
USB_Mouse=`xinput | grep Mouse | grep USB | awk -F "id=" '{print $2}' | awk '{print $1}'`
				#后边的两个awk是用来提取id的，所以请保证前边的grep能唯一过滤出想要的一行设备
xinput set-int-prop $USB_Mouse "Device Enabled" 8 0
#xinput set-int-prop $USB_Mouse "Device Enabled" 8 1			#某尾为1表示启用
