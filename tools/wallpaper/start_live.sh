#!/bin/zsh

i=0
for MONITOR in $(hyprctl monitors | grep Monitor | cut -d ' ' -f 2)
do
    i=$((i+1))
    MONITORS["$i"]="$MONITOR"
done
echo "$MONITORS"

MONITOR_ID=$(hyprctl activewindow | grep monitor | cut -d ' ' -f 2)

echo "这是$MONITOR_ID:${MONITORS[MONITOR_ID+1]}"

# pid=$(ps -ef | grep mpvpaper | grep -v grep | awk '{print $2}')
pid=$(ps -ef | grep ${MONITORS[MONITOR_ID+1]} | grep -v grep | awk '{print $2}')

echo "$pid"

if ! [ "$pid" = "" ]; then
    kill -9 "$pid"
else
    # 静音
    # 缩放视频适应屏幕
    mpvpaper -o "input-ipc-server=/tmp/mpv-socket$MONITOR_ID   --mute=yes --panscan=1.0 --loop-playlist=inf --loop-file=inf shuffle *" ${MONITORS[MONITOR_ID+1]} "$HOME/视频/wallpapers/"
    # mpvpaper -o "input-ipc-server=/tmp/mpv-socket   --mute=yes --panscan=1.0 --loop-playlist=inf --loop-file=inf shuffle *" HDMI-A-1 "$HOME/Videos/wallpapers/"
fi
