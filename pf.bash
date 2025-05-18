
#!/bin/bash

$n = $1;
$h = $2;

$dateiname = "processlist_" + date;

if [$h == "h"]
    then
        ps -ef > prozessbaum.txt | echo prozessbaum.txt
    else
        ps -ef --no-headers > prozessbaum.txt | echo prozessbaum.txt

    
