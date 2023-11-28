#! /bin/zsh

MONITOR_ID=$(hyprctl activewindow | grep monitor | cut -d ' ' -f 2)

i=0
for MONITOR in $(hyprctl monitors | grep Monitor | cut -d ' ' -f 2)
do
    i=$((i+1))
    MONITORS["$i"]="$MONITOR"
done
# echo "$MONITORS"
echo "这是$MONITOR_ID:${MONITORS[MONITOR_ID+1]}"

pid=$(ps -ef | grep mpvpaper | grep -v grep |grep "${MONITORS[MONITOR_ID+1]}" |awk '{print $2}')

if ! [ "$pid" = "" ]; then
    MONITOR_ID=$(hyprctl activewindow | grep monitor | cut -d ' ' -f 2)
    echo 'playlist-next' |  socat - /tmp/mpv-socket"$MONITOR_ID"
    exit
fi

NUMS=$(($(ls  ~/图片/wallpapers/ | cut -f 1 -d ' ' | wc -l)-1))
echo "NUMS:$NUMS"
I=0
NOW=$(swww query  | cut -d '/' -f 6)
CHE=$((RANDOM%NUMS))
ALL_IMG=$( ls  ~/图片/wallpapers/ | cut -f 1 -d ' ')
echo "CHE:$CHE"

for line in $(echo $ALL_IMG |grep -v $NOW)
do
    if [ $I -eq $CHE ]; then
        IMG_PATH=~/图片/wallpapers/$line
        break
    fi
    I=$((I+1))
    echo $I
    echo $line
done

echo "IMG_PATH:$IMG_PATH"

swww init
swww img $IMG_PATH -o "${MONITORS[MONITOR_ID+1]}" --transition-fps 120 --transition-step 20 --transition-type random --transition-duration 0.5
