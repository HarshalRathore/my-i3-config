#!/usr/bin/bash

. /home/harshal/.config/i3/scripts/dmenu_scripts/dmenu_themeing

Full_Screen='maim "$HOME/Pictures/$(date).png"'
Selection='maim --select "/home/$USER/Pictures/$(date).png"'
Active_Window='maim --window $(xdotool getactivewindow) "/home/$USER/Pictures/$(date).png"'
Clipboard_FullScreen='maim | xclip -selection clipboard -t image/png'
Clipboard_Selection='maim --select | xclip -selection clipboard -t image/png'
Clipboard_Active_Window='maim --window $(xdotool getactivewindow) | xclip -selection clipboard -t image/png'

SCREENSHOT=$(echo -e "Full_Screen\nSelection\nActive_Window\nClipboard_FullScreen\nClipboard_Selection\nClipboard_Active_Windows" | dmenu $PROMPT $LINE $FONT $COLOR)


if [[ $SCREENSHOT == "Full_Screen" ]]; then
    eval "$Full_Screen"
elif [[ $SCREENSHOT == "Selection" ]]; then
    eval "$Selection"
elif [[ $SCREENSHOT == "Active_Window" ]]; then
    eval "$Active_Window"
elif [[ $SCREENSHOT == "Clipboard_Selection" ]]; then
    eval "$Clipboard_Selection"
elif [[ $SCREENSHOT == "Clipboard_Active_Window" ]]; then
    eval "$Clipboard_Active_Window"
elif [[ $SCREENSHOT == "Clipboard_FullScreen" ]]; then
    eval "$Clipboard_FullScreen"
fi

exit 0
