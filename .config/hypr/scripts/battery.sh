#!/bin/bash

notify_levels=(25 15)
BAT=$(ls /sys/class/power_supply | grep BAT | head -n 1)
last_notify=100
last_status=""

while true; do
    bat_lvl=$(cat /sys/class/power_supply/${BAT}/capacity)
    bat_status=$(cat /sys/class/power_supply/${BAT}/status)

    # Notificación al cambiar el estado de carga
    if [[ "$bat_status" != "$last_status" ]]; then
        if [[ "$bat_status" == "Charging" ]]; then
            notify-send -u normal "🔌 Cargador conectado" "Batería al ${bat_lvl}%"
        elif [[ "$bat_status" == "Discharging" ]]; then
            notify-send -u normal "🔋 Cargador desconectado" "Batería al ${bat_lvl}%"
        elif [[ "$bat_status" == "Full" ]]; then
            notify-send -u normal "✅ Batería completa" "100% cargada"
        fi
        last_status=$bat_status
    fi

    # Notificaciones por niveles de batería baja
    if [[ "$bat_status" == "Discharging" ]]; then
        if [ $bat_lvl -gt $last_notify ]; then
            last_notify=$bat_lvl
        fi

        for notify_level in "${notify_levels[@]}"; do
            if [ $bat_lvl -le $notify_level ]; then
                if [ $notify_level -lt $last_notify ]; then
                    notify-send -u critical "🔋 Batería baja" "$bat_lvl% restante"
                    last_notify=$bat_lvl
                fi
            fi
        done
    fi

    sleep 60
done

