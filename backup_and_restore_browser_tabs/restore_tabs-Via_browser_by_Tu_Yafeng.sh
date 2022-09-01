#!/bin/sh

set -x

# Designed for:
#   - Sony Xperia XA1 (G3121),
#   - 720x1280 resolution (HD),
#   - Via browser (by Tu Yafeng) and

adb pull "${tabs_file_path}" "/tmp/tabs.txt"
sed -i '/^$/d' "/tmp/tabs.txt"

browser_main_activity="mark.via.gp/mark.via.Shell"

adb shell am start -W "${browser_main_activity}"
sleep 3

number_of_URLs=$(wc --lines "/tmp/tabs.txt" | cut --delimiter=' ' --fields=1)

for URL_line_number in $(seq 1 ${number_of_URLs})
do
  echo "${URL_line_number}"
  URL="$(head --lines=${URL_line_number} "/tmp/tabs.txt" | tail --lines=1 | tr -d '\r')"
  echo "${URL}"

  # Open tabs menu
  adb shell input touchscreen tap 500 1135
  sleep 2

  # New tab
  adb shell input touchscreen tap 360 1035
  sleep 2

  # Activate the address bar
  adb shell input touchscreen tap 360 100
  sleep 2

  # Enter link in address bar
  adb shell input text "${URL}"
  sleep 1

  # Open link in address bar
  adb shell input keyevent KEYCODE_ENTER
  sleep 4
done

