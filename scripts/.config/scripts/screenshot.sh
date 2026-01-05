#!/bin/bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +'%Y-%m-%d_%H-%M-%S').png"
grim -g "$(slurp)" "$FILE"
notify-send "Screenshot saved" "$FILE"
