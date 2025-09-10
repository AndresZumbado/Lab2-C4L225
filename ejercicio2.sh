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

gnuplot <<EOF
set datafile separator whitespace

set xdata time
set timefmt "%H:%M:%S"
set format x "%H:%M:%S"
set terminal pngcairo size 1000,600
set output "cpu.png"
set title "Consumo de CPU vs Tiempo"
set xlabel "Hora"
set ylabel "CPU (%)"
plot "consumo.log" using 1:2 with lines title "CPU"
EOF

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

