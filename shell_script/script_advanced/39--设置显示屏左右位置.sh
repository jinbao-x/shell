#!/bin/bash
#脚本功能：设置显示屏左右位置
#脚本思路：使用xrandr进行设置
#使用方法：修改显示屏标识，脚本方rc.local或其他合适位置
#使用环境：不限
#脚本编写：张瑞--国防事业本部

left=VGA-0
right=VGA-1
xrandr --output $left --auto --output $right --right-of $left --auto
