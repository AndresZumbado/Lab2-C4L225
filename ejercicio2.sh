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
sleep 0.5
PID=$!
> consumo.log
while pgrep -x "$proceso" > /dev/null; do
    hora=$(date +"%H:%M:%S")
    consumo=$(ps -C "$proceso" -o %cpu,%mem --no-headers | awk '{print $1" "$2}')
    echo "$hora $consumo" | tee -a consumo.log
    sleep 1
done
#Para graficar el consumo se crearan dos graficas separadas#una para CPU y otra para RAM. 
#Se utiliza <<EOF para excribir con la sintaxis de gnuplot a pesar de que el script es .sh

# Grafica CPU
gnuplot <<EOF
set datafile separator whitespace
#Se especifica que el formato es de tiempo
set xdata time
#Se especifica el formato del tiempo
set timefmt "%H:%M:%S"
set format x "%H:%M:%S"
#Aqui se especifica el size y se utiliza cairo para que
#las imagenes sean mas nitidas
set terminal pngcairo size 1000,600
#Se nombra el archivo, grafico y titulo de los ejes
set output "cpu.png"
set title "Consumo de CPU vs Tiempo"
set xlabel "Hora"
set ylabel "CPU (%)"
#FInalmente se crea el grafico
plot "consumo.log" using 1:2 with lines title "CPU"
EOF

#Ahora se ejecuta el mismo proceso pero para la grafica de la RAM
#
# Grafica RAM
gnuplot <<EOF
set datafile separator whitespace
set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M:%S"
set terminal pngcairo size 1000,600
set output "ram.png"
set title "Consumo de RAM vs Tiempo"
set xlabel "Hora"
set ylabel "RAM (%)"
plot "consumo.log" using 1:3 with lines title "RAM"
EOF

