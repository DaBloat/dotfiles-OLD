#!/bin/sh
sed -i \
         -e 's/#0c1717/rgb(0%,0%,0%)/g' \
         -e 's/#a0b5b7/rgb(100%,100%,100%)/g' \
    -e 's/#1b3434/rgb(50%,0%,0%)/g' \
     -e 's/#ffffff/rgb(0%,50%,0%)/g' \
     -e 's/#224242/rgb(50%,0%,50%)/g' \
     -e 's/#a0b5b7/rgb(0%,0%,50%)/g' \
	"$@"
