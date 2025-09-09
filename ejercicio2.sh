#!/bin/bash

proceso=$1

if [ -z proceso ]; then
	echo "Debe introducir un proceso a agregar"
	exit 1
fi

$proceso
