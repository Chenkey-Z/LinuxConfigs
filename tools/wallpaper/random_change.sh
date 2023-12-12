#! /bin/zsh

MONITOR_ID=$(hyprctl activewindow | grep monitor | cut -d ' ' -f 2 | head -1)
[ ! "$MONITOR_ID" ] && MONITOR_ID=0

i=0
for MONITOR in $(hyprctl monitors | grep Monitor | cut -d ' ' -f 2); do
	i=$((i + 1))
	MONITORS["$i"]="$MONITOR"
done
# echo "$MONITORS"
echo "这是$MONITOR_ID:${MONITORS[MONITOR_ID + 1]}"

# pass the property as the first argument
mpv_communicate() {
	printf '{ "command": ["get_property", "%s"] }\n' "$1" | socat - "/tmp/mpv-socket$MONITOR_ID" | jq -r ".data"
}

pid=$(ps -ef | grep mpvpaper | grep -v grep | grep "${MONITORS[MONITOR_ID + 1]}" | awk '{print $2}')

if ! [ "$pid" = "" ]; then
    # MONITOR_ID=$(hyprctl activewindow | grep monitor | cut -d ' ' -f 2)
    # if [ $MONITOR_ID = "" ]; then
    #     MONITOR_ID=0
    # fi
    echo 'playlist-next' | socat - /tmp/mpv-socket"$MONITOR_ID"
    # dunstify "随机切换动态壁纸" -i "$IMG_PATH" -r 91190 -t 2200
    WORKING_DIR="$(mpv_communicate "working-directory")"
    FILEPATH="$(mpv_communicate "path")"
    FILENAME=$(echo "$FILEPATH" | choose --field-separator '/' -1)

	dunstify "屏幕ID:$MONITOR_ID
随机切换动态壁纸" -i "$HOME/视频/wallpapers/.cache/$FILENAME" -r 91190 -t 2200
	exit
fi

NUMS=$(($(ls ~/图片/wallpapers/ | cut -f 1 -d ' ' | wc -l) - 1))
echo "NUMS:$NUMS"
I=0
NOW=$(swww query | cut -d '/' -f 6)
CHE=$((RANDOM % NUMS))
ALL_IMG=$(ls ~/图片/wallpapers/ | cut -f 1 -d ' ')
echo "CHE:$CHE"

for line in $(echo $ALL_IMG | grep -v $NOW); do
	if [ $I -eq $CHE ]; then
		IMG_PATH=~/图片/wallpapers/$line
		break
	fi
	I=$((I + 1))
	echo $I
	echo $line
done

echo "IMG_PATH:$IMG_PATH"

swww init
swww img $IMG_PATH -o "${MONITORS[MONITOR_ID + 1]}" --transition-fps 120 --transition-step 20 --transition-type random --transition-duration 0.5

dunstify "随机切换壁纸" -i "$IMG_PATH" -r 91190 -t 2200
