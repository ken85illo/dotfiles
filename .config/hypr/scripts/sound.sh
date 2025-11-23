#!/usr/bin/env bash

declare volume

function get_volume {
    wpctl get-volume @DEFAULT_AUDIO_SINK@
}

function get_volume_int {
    get_volume | awk '{print int($2*100)}'
}

function get_volume_status {
    if [[ -z "$(get_volume | cut -d ' ' -f 3)" ]]; then
        echo "[UNMUTED]"
        return
    fi
    echo "[MUTED]"
}

if [[ $1 == "up" ]]; then
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
elif [[ $1 == "down" ]]; then
    wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-
elif [[ $1 == "mute" ]]; then
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
fi

volume=$(get_volume_int)
status=$(get_volume_status)
dunstify -r 9999 -h "int:value:$volume" "Volume: $volume% $status" -t 3000
