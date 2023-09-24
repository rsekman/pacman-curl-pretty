#!/usr/bin/sh

cols=$(tput cols)
hs=$(printf "%${cols}s" | sed -e 's/ /#/g')
ds=$(printf "%${cols}s" | sed -e 's/ /-/g')
fname=linux-6.5.4-arch2-1

awk -f ../src/pacman-curl-pretty.awk \
    -v ORS='\n' \
    -v fname=$fname \
    -v cols=$cols \
    -v hs=$hs \
    -v ds=$ds \
    test.txt
