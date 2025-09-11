#!/bin/bash

$ruta=$1
if [ -z "$usuario" ]; then
	echo "Debe agregar un directorio a evaluar"
	exit 1
fi

if [ ! -f "$ruta" ]; then
	echo "La ruta del archivo no existe"
        exit 3
fi


