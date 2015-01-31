#!/bin/bash

temp=`curl -s "http://www.google.com/ig/api?weather=Montreal" | sed 's|.*<temp_c data="\([^"]*\)"/>.*|\1\°C|'`
echo $tempf
if [ $temp ]; then
    if [[ $temp == *"-"* ]]; then
	echo '#[fg=blue]'$temp
    else
	echo '#[fg=red]'$temp
    fi
else
	echo -
fi
