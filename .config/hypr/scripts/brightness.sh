#!/usr/bin/env bash

function get_brightness_percentage {
    echo "$(brightnessctl get) $(brightnessctl max)" | awk '{print int($1/$2*100)}'
}


if [[ $1 == "up" ]]; then
    brightnessctl -e4 -n2 set 5%+
elif [[ $1 == "down" ]]; then
    brightnessctl -e4 -n2 set 5%-
fi

brightness=$(get_brightness_percentage)
dunstify -r 9999 -h "int:value:$brightness" "Brightness: $brightness%" -t 3000
