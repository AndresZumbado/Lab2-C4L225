#!/bin/bash


usuario=$1
grupo=$2
ruta=$3

if [ "$USER" != "root" ]; then
	echo "Debe iniciar sesion como root"
	exit 1
fi

if [[ -z "$usuario" || -z "$grupo" || -z "$ruta" ]]; then
	echo "Debe incluir nombre de usuario, grupo y ruta del archivo"
	exit 2
fi
if [ ! -f "$ruta" ]; then
	echo "La ruta del archivo no existe"
	exit 3
fi
if ! grep -q "^$grupo:" /etc/group; then
	echo "El grupo no existe"
	exit 4
fi

if ! id "$usuario" &>/dev/null; then
	adduser "$usuario"
	usermod -a -G "$grupo" "$usuario"
else
	echo "el usuario ya existe, se agregara al grupo"
	usermod -a -G "$grupo" "$usuario"
fi


