#!/usr/bin/env sh
RofiConf="$HOME/.config/rofi/themeselect.rasi"
# scale for monitor x res
x_monres=`cat /sys/class/drm/*/modes | head -1 | cut -d 'x' -f 1`
# x_monres=$(( x_monres*17/100 ))
x_monres=$(( x_monres*17/100 ))


# set rofi override
elem_border=$(( hypr_border * 3 ))
r_override="element{border-radius:${elem_border}px;} listview{dynamic:true;columns:5;spacing:100px;} element{padding:0px;orientation:vertical;} element-icon{size:${x_monres}px;border-radius:0px;} element-text{padding:20px;}"

MONITOR_ID=$(hyprctl activewindow | grep monitor | cut -d ' ' -f 2)
i=0
for MONITOR in $(hyprctl monitors | grep Monitor | cut -d ' ' -f 2)
do
    i=$((i+1))
    MONITORS["$i"]="$MONITOR"
done

echo "这是$MONITOR_ID:${MONITORS[MONITOR_ID+1]}"

LiveWallPath="$HOME/视频/wallpapers/"

pid=$(ps -ef | grep mpvpaper | grep -v grep |grep "${MONITORS[MONITOR_ID+1]}" |awk '{print $2}')

if ! [ "$pid" = "" ]; then

    # diff  "$LiveWallPath" "$LiveWallPath"/.cache | grep '只在'
    # DIFF_STR=$(diff  "$LiveWallPath" "$LiveWallPath"/.cache | grep -v cache |grep '只在 . 中存在：' | tr   "：" " " | cut -d ' ' -f 6)
    DIFF_STR=$(diff  "$LiveWallPath" "$LiveWallPath"/.cache | grep -v cache | grep '只' | tr '：' ' ' |cut -d ' ' -f 6)

    echo "$DIFF_STR" | while read diff_f
    do
        ffmpeg -i "$LiveWallPath/$diff_f" -ss 00:00:02 "$LiveWallPath/.cache/$diff_f.png"
        mv "$LiveWallPath/.cache/$diff_f.png" "$LiveWallPath/.cache/$diff_f"
    done

    # launch rofi menu
    RofiSel=$( ls $LiveWallPath | while read rfile
        do
            # ffmpeg -i "$LiveWallPath/$rfile" -r 1 "$rfile".png
            echo -en "$rfile\x00icon\x1f$LiveWallPath/.cache/$rfile\n"
    done | rofi -dmenu -theme-str "${r_override}" -config $RofiConf)

    if [ -z $RofiSel ] ; then
        exit
    fi

    echo "loadfile $LiveWallPath$RofiSel" | socat - /tmp/mpv-socket"$MONITOR_ID"
    dunstify "切换动态壁纸" -i "$LiveWallPath/.cache/$RofiSel" -r 91190 -t 2200

    exit
fi

# set variables
ScrDir=`dirname $(realpath $0)`
# source $ScrDir/globalcontrol.sh
# WallPath="$HOME/.config/swww/$gtkTheme"
WallPath="$HOME/图片/wallpapers/"


# launch rofi menu
RofiSel=$( ls $WallPath | while read rfile
    do
        # echo -en "$rfile\x00icon\x1f${cacheDir}/${gtkTheme}/${rfile}\n"
        echo -en "$rfile\x00icon\x1f$WallPath/$rfile\n"
done | rofi -dmenu -theme-str "${r_override}" -config $RofiConf)


# apply wallpaper
if [ ! -z $RofiSel ] ; then
    # ${ScrDir}/swwwallpaper.sh -s $WallPath/$RofiSel
    # ${ScrDir}/swwwallpaper.sh -s $WallPath/$RofiSel
    dunstify "切换壁纸" -a " ${RofiSel}" -i "$WallPath/$RofiSel" -r 91190 -t 2200
    swww init
    swww img "$WallPath/$RofiSel" -o "${MONITORS[MONITOR_ID+1]}" --transition-fps 120 --transition-step 15 --transition-type random --transition-duration 0.5
fi
