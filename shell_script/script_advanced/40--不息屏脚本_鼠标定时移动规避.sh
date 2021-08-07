#!/bin/bash
#脚本功能：不息屏脚本
#脚本思路：通过每隔一段时间移动鼠标规避
#使用方法：脚本所在的绝对路径到加rc.local或其他合适位置
#使用环境：不限
#脚本编写：李哲--国防事业本部

time=10		#间隔时间(单位秒)
while true
do
	xdotool mousemove_relative  1 1
sleep $time
done



