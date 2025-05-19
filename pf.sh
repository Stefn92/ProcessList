#!/bin/bash

datum=$(date)
dateiname="processlist_$datum.txt"
    
while getopts ":hn:" opt; 
do
    case $opt in
        n) 
            pgrep -a "$OPTARG" > "$dateiname"
            ;;
        h) 
            echo "PID   Befehl" > "$dateiname"
            pgrep -a "$OPTARG" > "$dateiname"
            ;;
        *)
            ;;    
    esac
done            

cat "$dateiname"