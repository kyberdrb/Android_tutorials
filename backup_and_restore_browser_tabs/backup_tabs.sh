#!/bin/sh

set -x  

# Optimized for
#   - Samsung Galaxy J3 2016,
#   - 720x1280 resolution,
#   - Vivaldi browser and
#   - QuickEdit+ v1.8.4

# Pre-conditions
#   - Start with Vivaldi browser opened at the first tab (in the first group if you have any)
#   - Click in the address bar to activate the text in it, then press the 'BACK' key t show the page
#   - Empty file in "tabs.txt" stored in the internal phone memory
#   - All tabs have their unique URL - equality of the URLs is the stopping condition

# In UNIX/LINUX/POSIX world, '0' is 'true', '1' or number greater than 1 is 'false' 

isFirstIteration="0"
first_and_last_url_were_matching_only_in_first_iteration="1"
last_and_forelast_url_are_different="1"

#while true
while \
       [ "${isFirstIteration}" = "0" ] \
    || [ "${first_and_last_url_were_matching_only_in_first_iteration}" = "0" ] \
    || [ "${last_and_forelast_url_are_different}" = "0" ]
do
  printf "%s\n%s\n%s\n\n" \
    "isFirstIteration=${isFirstIteration}" \
    "first_and_last_url_were_matching_only_in_first_iteration=${first_and_last_url_were_matching_only_in_first_iteration}" \
    "last_and_forelast_url_are_different=${last_and_forelast_url_are_different}"

  adb shell am start -W com.vivaldi.browser/com.google.android.apps.chrome.Main
  sleep 3
  
  #adb shell input touchscreen tap 360 110
  adb shell input touchscreen swipe 360 110 360 110 3000
  sleep 3
  
  adb shell input touchscreen tap 565 325
  sleep 3
  adb shell input keyevent KEYCODE_BACK
  sleep 3
  adb shell input keyevent KEYCODE_BACK
  sleep 3

  adb shell am start -W com.rhmsoft.edit.pro/com.rhmsoft.edit.activity.MainActivity
  sleep 1
  # Edit
  adb shell input touchscreen tap 575 100
  sleep 1
  # Paste
  adb shell input touchscreen tap 510 390
  sleep 1

  adb shell input keyevent KEYCODE_ENTER

  # File
  adb shell input touchscreen tap 475 100
  sleep 1
  # Save
  adb shell input touchscreen tap 510 390
  sleep 1
  
  tabs_file_path='/sdcard/tabs.txt'
  first_url="$(adb shell cat "${tabs_file_path}" | head -n 1)"
  last_url="$(adb shell cat "${tabs_file_path}" | tail -n 1)"

  test "${first_url}" = "${last_url}"
  first_and_last_url_are_matching=$?

  forelast_url="$(adb shell cat "${tabs_file_path}" | tail -n 2 | head -n 1)"
  test "${last_url}" != "${forelast_url}"
  last_and_forelast_url_are_different=$?

  if [ "${isFirstIteration}" = "1" ] && [ "${first_and_last_url_were_matching_only_in_first_iteration}" = "0" ]
  then
    first_and_last_url_were_matching_only_in_first_iteration="1"
  fi

  if [ "${isFirstIteration}" = "0" ]
  then
    isFirstIteration="1"
    first_and_last_url_were_matching_only_in_first_iteration="0"
  fi

  adb shell am start -W com.vivaldi.browser/com.google.android.apps.chrome.Main
  sleep 2
  adb shell input touchscreen swipe 550 110 150 110 600
  sleep 15
done

# TODO test: Remove last duplicate URL
#adb shell cat "${tabs_file_path}" | head -n -1

# TODO Insert between links an empty new line
