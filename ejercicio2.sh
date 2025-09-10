#!/bin/bash

proceso=$1
if [ -z "$proceso" ]; then
	echo "Debe introducir un proceso a agregar"
	exit 1
fi

if [ -z "$(command -v $proceso)" ]; then
	echo "El proceso no existe"
	exit 2
fi

$proceso &
PID=$!

while kill -0 "$PID" 2>/dev/null; do
    hora=$(date +"%H:%M:%S")
    consumo=$(ps -p "$PID" -o %cpu,%mem --no-headers)
    echo "$hora $consumo" | tee -a consumo.log
    sleep 1
done

