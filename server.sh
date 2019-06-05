#!/bin/bash

FILE="$HOME/logs/uso-server.csv"

if [ -f "$FILE" ]
then
    echo "$FILE existe, generando logs"
else
    touch $FILE && echo "creando $FILE y generando logs"
fi

# Fecha de Servidor
echo -n `date +"%d/%m/%Y|%H:%M:%S,"` >> $FILE

# Tiempo activo de servidor
uptime | awk -F'( |,|:)+' '{printf("%s:%s,", ($6 * 24 + $8),  $9)}' >> $FILE

# Uso de CPU de servidor
top -bn1 | grep Cpu | awk '{printf("%s,", $2)}' >> $FILE

# Uso de RAM de servidor (Usado, Disponible, Total)
free -h | awk 'NR ==2 { printf("%s,%s,%s,", $3, $7, $2) }' >> $FILE

# Numero de tareas
top -bn1 | grep Task | awk '{ printf("%s\n", $2) }' >> $FILE
