#!/bin/sh

set -x

LINK="$1"

# Optimized for
#   - Samsung Galaxy J3 2016,
#   - 720x1280 resolution,
#   - Vivaldi browser

# Pre-conditions
#   - Vivaldi browser opened at blank tab overview, i.e. without tabs but one [because Vivaldi opens quick launch tab immediately after closing the last tab] - disable 'Show tab list' - then minimize the browser

adb shell am start -W com.vivaldi.browser/com.google.android.apps.chrome.Main
sleep 3

# New tab
adb shell input touchscreen tap 645 1230
sleep 5

# Activate address bar
adb shell input touchscreen swipe 360 130 360 130 500
sleep 3
adb shell input touchscreen tap 360 130
sleep 2

# Enter link in address bar
adb shell input text "${LINK}"
sleep 1

# Open link in address bar
adb shell input keyevent KEYCODE_ENTER
sleep 10

# Open tab overview
adb shell input touchscreen swipe 360 110 360 2000 2000

# README.md
#Sources
#- https://unix.stackexchange.com/questions/7011/how-to-loop-over-the-lines-of-a-file/670789#670789
#- https://developer.android.com/reference/android/view/KeyEvent
#- https://stackoverflow.com/questions/7789826/adb-shell-input-events
#- https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-xp/bb490982(v=technet.10)?redirectedfrom=MSDN
