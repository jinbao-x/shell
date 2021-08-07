#!/bin/bash
#脚本功能：蓝屏规避脚本
#脚本思路：使用xset设置屏幕信号源关闭一次，以此纠正某种错误信号
#使用方法：脚本绝对路径家到rc.local或其他合适位置
#使用环境：此脚本曾用在成都29所蓝屏问题上，用作规避方案
#脚本编写：徐金宝--国防事业本部

xset dpms force off
sleep 0.01
xset dpms force on
