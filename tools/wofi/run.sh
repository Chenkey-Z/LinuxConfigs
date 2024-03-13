#!/bin/bash

export XAUTHORITY="${XAUTHORITY:-$HOME/.Xauthority}"
wofi --show drun
# env >~/tools/wofi/txt
