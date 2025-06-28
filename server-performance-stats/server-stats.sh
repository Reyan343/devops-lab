#!/bin/bash


CPU_usage="$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')"
echo "CPU Usage: ${CPU_usage}"

RAM_usage="$(free | grep Mem | awk '{print $3/$2 * 100.0'})"
RAM_USED="$(free -h | grep Mem | awk '{print $3}')"
RAM_TOTAL="$(free -h | grep Mem | awk '{print $2}')"

echo "MEMORY USED: ${RAM_USED}/${RAM_TOTAL} ${RAM_usage}%"

Dsk_used="$(df -Hl | grep /home | awk '{print $3 "/" $2, $5}')"

echo "Disk Usage: ${Dsk_used}"

CPU_use="$(ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6)"

echo "TOP 5 PROGRAMS USING CPU"
echo "${CPU_use}"

ram_use="$(ps -eo pid,comm,%mem,rss --sort=-%mem | awk 'NR==1{print $0, "MEM_USAGE"} NR>1{printf "%s %s %s %s %.1fMB\n", $1, $2, $3, $4, $4/1024}' | head -n 6)"

echo "TOP 5 PROGAMS USING MEMORY"
echo "${ram_use}"
