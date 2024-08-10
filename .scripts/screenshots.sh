#!/bin/bash


FILE_NAME=~/Pictures/screenshots/$(date +'%s.png')
case $1 in
	pc)
		grim -g "$(slurp -w 0)" - | wl-copy
		dunstify "Screenshot Copied!" -i "screenshot-copy" -r 1113 -t 3000
		;;
	w)
		grim $FILE_NAME
		dunstify "Screenshot Saved!" "@$FILE_NAME" -i "$FILE_NAME" -r 1113 -t 3000
		;;
	p)

		grim -g "$(slurp -w 0)" $FILE_NAME
		dunstify "Screenshot Saved!" "@$FILE_NAME" -i "$FILE_NAME" -r 1113 -t 3000
		;;
	wc)
		grim - | wl-copy
		dunstify "Screenshot Copied!" -i "screenshot-copy" -r 1113 -t 3000
		;;

esac





