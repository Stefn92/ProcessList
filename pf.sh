
#!/bin/bash

$dateiname = "processlist_" + date + ".txt"
    
while getopts ":hn:" opt; 
do
    case $opt in
        n) 
            $n = $OPTARG 
            ps -ef | grep $OPTARG > "$dateiname"
            ;;
        n) 
            $n = $OPTARG 
            ps -ef --no-headers | grep $OPTARG > "$dateiname"
            ;;
    esac
done            

cat "$dateiname"