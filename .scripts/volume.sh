#!/bin/bash
# Created by DaBloat
case $1 in
	u)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
		wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
		;;
	d)
		wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
		;;
	m)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle 
		;;
esac

STATUS=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $NF;}')

notification(){
	case $STATUS in
		"[MUTED]")
			dunstify "Volume is in mute" -r 1111 -i "volume-mute" -t 2000
			;;
		*)
			VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tr -dc '0-9' | sed 's/^0\{1,2\}//')
			if [ "$VOLUME" -lt 35 ];
			then
				ICON="off";
			elif [ "$VOLUME" -lt 65 ];
			then
				ICON="min";
			else 
				ICON="high";
			fi
                      dunstify "Volume @ ${VOLUME}%" -r 1111 -h int:value:"$VOLUME" -i "volume-$ICON" -t 2000
	esac
}

notification


