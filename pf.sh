#!/bin/bash

# aktuelles Datum und Uhrzeit
datum=$(date +"%Y-%m-%d_%H-%M-%S")

# Dateiname für die Ausgabe
dateiname="processlist_$datum"

# String, nach dem die Prozessliste durchsucht wird
gesucht=""

# Flag, ob der Header mit angegeben werden soll oder nicht
include_header=false

# Nette Beschreibung 
echo "Anzeige der Datei \"$dateiname\" mit den Prozessen die den String \"$gesucht\" enthalten:"
echo ""

# Auswertung der übergebenen Parameter
while getopts ":n:h" opt; do
   case $opt in
   n)
       gesucht=$OPTARG
       ;;
   h)
       include_header=true
       ;;
   :) 
      echo "Fehler: Option -$OPTARG benötigt ein Argument." >&2
      exit 1
      ;;    
   \?)
      echo "Unbekannte Option: -$OPTARG" >&2
      exit 1
      ;;   
   *) ;;
   esac
done

# Überprüfen, ob überhaupt Optionen übergeben wurden
if [ $OPTIND -eq 1 ]; then
  echo "Fehler: Es wurden keine Optionen übergeben." >&2
  exit 1
fi

# Prüfen, ob -n gesetzt wurde
if [ -z "$gesucht" ]; then
  echo "Fehler: -n <wert> ist erforderlich." >&2
  exit 1
fi

# Prüfen, ob der Header mit angegeben werden soll
if [ "$include_header" = true ]; then
   (
       # Header wird erzeugt und in die Datei geschrieben
       ps -eo pid,tty,time,comm,%cpu --sort=pid | head -1 > "$dateiname"
   ) 
fi

# Gefilterte Prozessliste wird erzeugt und in der Datei angehängt
ps -eo pid,tty,time,comm,%cpu --sort=pid --no-headers | grep $gesucht >> "$dateiname"

# Dateiinhalt wird ausgegeben
cat "$dateiname"
