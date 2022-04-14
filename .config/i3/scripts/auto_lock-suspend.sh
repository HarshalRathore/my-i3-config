#!/usr/bin/env bash

# Only exported variables can be used within the timer's command.
export PRIMARY_DISPLAY="$(xrandr | awk '/ primary/{print $1}')"

killall xidlehook

# Run xidlehook
xidlehook \
  `# Don't lock when there's a fullscreen application` \
  --not-when-fullscreen \
  `# Don't lock when there's audio playing` \
  --not-when-audio \
  `# Dim the screen after 300 seconds, undim if user becomes active` \
  --timer 300 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness .1' \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1' \
  `# Undim & lock after 60 more seconds` \
  --timer 60 \
    'xrandr --output "$PRIMARY_DISPLAY" --brightness 1 && ~/.config/i3/scripts/blur-lock.sh' \
    '' \
  `# Finally, suspend after 300 seconds after it locks` \
  --timer 300 \
    'systemctl suspend' \
    ''

