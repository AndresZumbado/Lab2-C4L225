#!/bin/bash


usuario=$1
grupo=$2
ruta=$3

#La primera seccion se encargara de cubrir los casos que requieran el cierre del script

#//////////////////////////////////////////////////////////////////////////////////////////////////////////////
#Primero se verifica que el script sea ejecutado por el usuario root, si no, se manda error 1
if [ "$USER" != "root" ]; then
	echo "Debe iniciar sesion como root"
	exit 1
fi

#Se verifica que se hayan introducido al menos tres variables de entrada
if [[ -z "$usuario" || -z "$grupo" || -z "$ruta" ]]; then
	echo "Debe incluir nombre de usuario, grupo y ruta del archivo"
	exit 2
fi

#Se verifica que el archivo exista
if [ ! -f "$ruta" ]; then
	echo "La ruta del archivo no existe"
	exit 3
fi #Fin de la revision de casos
#//////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Ahora con la ejecucion correcta del script, se comienza creando el grupo. Si ya existe se imprime un mensaje
if ! grep -q "^$grupo:" /etc/group; then
	addgroup "$grupo"
else
	echo "El grupo ya existe"
fi

#Ahora se crea el usuario (si ya existe se imprime un mensaje) y se agrega al grupo. Se agrego &>/dev/null 
#para que no aparezca la salida del comando ni el error en la consola. 
if ! id "$usuario" &>/dev/null; then
	adduser "$usuario"
	usermod -a -G "$grupo" "$usuario"
else
	echo "El usuario ya existe, se agregara al grupo"
	usermod -a -G "$grupo" "$usuario"
fi

#Cambiar la pertenencia del archivo
chown "$usuario:$grupo" "$ruta"
#Cambiar los permisos del aerchivo
chmod 740 "$ruta"
