#!/bin/bash

usuario=$('whoami')
echo "$usuario"
if [ "$usuario"="root" ]; then
	echo "Saico mae"
elif [ "$usuario"="andresvirtual" ]; then
	echo "va por ahi"
fi

