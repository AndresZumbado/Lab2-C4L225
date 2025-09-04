#!/bin/bash

working_user=$1
group=$2
file_path=$3

echo "$USER"
if [ "$USER" = "root" ]; then
	echo "Good joob"
	if [[ ! -z "$working_user" || !  -z "$group"  || !  -z "$file_path" ]]; then
		echo "Nice"
	fi

else 
	echo "Needs to be logged in as root"
	exit 1
fi

