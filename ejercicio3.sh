#!/bin/bash

directorio="/home/andresvirtual/Downloads"
archivo_log="/home/andresvirtual/Documents/cambios.log"

> "$archivo_log"
inotifywait -m -r -e create -e modify -e delete "$directorio" --format '%w%f %e' |
while read archivo evento
do
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $evento en $archivo" >> "$archivo_log"
done


