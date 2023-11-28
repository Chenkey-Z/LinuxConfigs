#!/bin/bash

MONITOR_ID=$(hyprctl activewindow | grep monitor | cut -d ' ' -f 2)
echo "$1" | socat - /tmp/mpv-socket"$MONITOR_ID"
