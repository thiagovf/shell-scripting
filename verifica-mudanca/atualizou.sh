#!/bin/bash
URL=""
INTERVAL=300 #in seconds.
LINES=120
#getting the initial state
HOUR=`date +%H`

wget -q $URL -O beginning_state
while [ $HOUR -ne "16" ]; do
    echo $(date +%Y-%m-%d:%H:%M:%S)
    wget -q $URL -O new_state
    DIFF=$(diff -U 0 new_state beginning_state  | grep -v ^@ | wc -l)
    if [ "$LINES" -le "$DIFF" ]
    then
	zenity --info --text="Atualizado!!" | cp new_state beginning_state
    fi
    sleep $INTERVAL's'
done

