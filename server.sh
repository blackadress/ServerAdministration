#!/bin/bash

# Tiempo activo de servidor
uptime | awk -F'( |,|:)+' '{printf("%s:%s ", ($6 * 24 + $8),  $9)}' >> log.csv

# Uso de CPU de servidor
top -bn1 | grep Cpu | awk '{printf("%s ", $2)}' >> log.csv

# Uso de RAM de servidor (Usado, Disponible, Total)
free -h | awk 'NR ==2 { printf("%s %s %s ", $3, $7, $2) }' >> log.csv

# Numero de tareas
top -bn1 | grep Task | awk '{ printf("%s\n", $2) }' >> log.csv
