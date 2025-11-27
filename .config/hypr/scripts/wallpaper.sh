#!/usr/bin/env bash

background_txt="$HOME/.config/hypr/background.txt"

(
    cd "$HOME/.config/hypr/background-images/" || exit
    if [[ $1 == "init" && -e $background_txt ]]; then
        path=$(cat "$background_txt")
    else
        path=$(realpath "$(find ./*.jpg ./*.png | sort -d | sed 's|^\./||' | wofi --dmenu)")
        echo "$path" > "$background_txt"
    fi

    awww img "$path" --transition-type center
)
