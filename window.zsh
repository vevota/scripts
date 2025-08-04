#!/bin/zsh

# Find the window ID of the "Path of Exile" window
window_id=$(xdotool search --name "Path of Exile")

# Remove window decorations
xprop -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x2, 0x0, 0x0"

# Resize the window to 2560x1080
xdotool windowsize $window_id 2560 1080

# Move the window to the top-left corner of the screen (optional)
xdotool windowmove $window_id 0 0
