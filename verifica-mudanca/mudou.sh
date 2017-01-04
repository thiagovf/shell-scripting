#!/bin/bash

#                       bash page-up.sh &
#---------------------------------------------------------------
# to check every INTERVAL seconds if a given URL changed 
#                  (since the beginning of the script execution)
# WHILE DATE is not reached
#    IF it changes 
#      popup notify 

#parameters
SUBJECT="UFC Warning"
URL="http://tracking.totalexpress.com.br/tracking_encomenda.php?code=6%2BCccGfR2KPYgfJdUqZffwe3Y5wIYCV9ypQljDdSd7waSYZK%2BrmMPPsUD4pZqbCXOAPUqq%2F48pikxRvuVuBZHW2bUnObs9poXa5ZInRl8nzMrvhY9%2F3JeSwIPBLqS4h0C1bHEiVzpYfKhktEL2JUAgJocNU%3D"
DATE=$(date --date='2017-01-16 23:59:59 UTC' +%s)
INTERVAL=3600 #in seconds.
LINES=90

#getting the initial state
wget -q $URL -O beginning_state
while [ "$(date +%s)" -le "$DATE" ]
do
	echo $(date +%Y-%m-%d:%H:%M:%S)
    wget -q $URL -O new_state
    DIFF=$(diff -U 0 new_state beginning_state  | grep -v ^@ | wc -l)
    if [ "$LINES" -le "$DIFF" ]
    then
#changed.
{
notify-send -i /path//to/icon.png "Atualizado!!"
} | cp new_state beginning_state
    fi
#not changed.
    sleep $INTERVAL's'
	
    #uncomment the line bellow to simulate an update:
    #echo "updated!" >> beginning_state
done
