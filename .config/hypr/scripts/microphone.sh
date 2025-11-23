#!/usr/bin/env bash

function get_mic_status {
    if [[ -z "$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | cut -d ' ' -f 3)" ]]; then
        echo "Enabling Microphone"
        return
    fi
    echo "Disabling Microphone"
}

wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
notify-send -r 9999 "$(get_mic_status)" -t 3000

