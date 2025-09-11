#!/bin/bash

#Directorio y ruta de archivo escogidos arbitrariamente en mi maquina
directorio="/home/andresvirtual/Downloads"
archivo_log="/home/andresvirtual/Documents/cambios.log"

#Se asegura que el archivo exista y este vacio
> "$archivo_log"
#Se activa el inotifywait
#-m activa el modo de monitoreo
#-r es el modo de recursividad que permite ver cambios en subdirectorios
#--format expecifica el formato
inotifywait -m -r -e create -e modify -e delete "$directorio" --format '%w%f %e' |
while read archivo evento
do
	#Se guarda en el cambios.log con la fecha y hora del evento
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $evento en $archivo" >> "$archivo_log"
done


