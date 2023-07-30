#!/bin/sh
sed -i \
         -e 's/#1c1e26/rgb(0%,0%,0%)/g' \
         -e 's/#bbbbbb/rgb(100%,100%,100%)/g' \
    -e 's/#1c1e26/rgb(50%,0%,0%)/g' \
     -e 's/#E95678/rgb(0%,50%,0%)/g' \
     -e 's/#2e303e/rgb(50%,0%,50%)/g' \
     -e 's/#bbbbbb/rgb(0%,0%,50%)/g' \
	"$@"
