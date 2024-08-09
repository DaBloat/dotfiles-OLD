#!/bin/bash
# created by DaBloat


case $1 in
	u)
		brightnessctl -q s +8%
		;;
	d)
		brightnessctl -q s 8%-
		;;
esac

brightness=$(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')
notification(){
	if [ "$brightness" -lt 50 ]; 
	then
		ICON="low";
	else
		ICON="high";
	fi
	dunstify "Backlight @ ${brightness}%" -r 1112 -h int:value:$brightness -i "brightness-$ICON" -t 1000
}

notification
