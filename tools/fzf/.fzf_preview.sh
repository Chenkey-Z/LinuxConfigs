#!/bin/bash

if file --mime-type "$1" | grep -qF image/; then
	kitty icat --clear --transfer-mode=memory --stdin=no --place="$FZF_PREVIEW_COLUMNS"x"$FZF_PREVIEW_LINES"@0x0 "$1"
elif test -d "$1"; then
	lsd --tree --icon=always --color=always "$1"
	kitty icat --clear
elif test -f "$1"; then
	bat --color=always "$1"
	kitty icat --clear
fi
