#! /bin/bash

sessions=($(screen -ls|grep --color=never -G ')$'| sed -e 's/^[ \t]*//' -e 's/[ \t](.*)$/ /' |tr '\n' ' '))
if [ ${#sessions[@]} -lt 2 ];then
    screen -d -R
    exit 0
fi

if [ $# -lt 1 ]; then
    screen -ls
    read SELECTED
else 
    SELECTED=$1
fi
echo "${sessions[@]}"
if [[ "$SELECTED" =~ ^[^0-9]*$ ]]; then
    echo "You can only give me a number"
elif [ -z "${sessions}" ] ; then
    echo "No screen sessions open..."
elif [ "$SELECTED" -gt "${#sessions[@]}" ] || [ "$SELECTED" -le 0 ]; then 
    echo "No corresponding screen session"
else
   screen -d -r ${sessions[$((SELECTED-1))]}
fi
