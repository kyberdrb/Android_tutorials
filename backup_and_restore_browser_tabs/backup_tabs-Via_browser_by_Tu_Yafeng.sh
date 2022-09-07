#!/bin/sh

set -x  

# Notes to the variable boolean values: In UNIX/LINUX/POSIX environment, '0' is 'true'/SUCCESS, '1' or number greater than 1 is 'false'/FAILURE

isFirstIteration="0"
first_and_last_url_were_matching_only_in_first_iteration="1"
last_and_first_url_are_different="1"

while \
       [ "${isFirstIteration}" = "0" ] \
    || [ "${first_and_last_url_were_matching_only_in_first_iteration}" = "0" ] \
    || [ "${last_and_first_url_are_different}" = "0" ]
do
  printf "%s\n%s\n%s\n\n" \
    "isFirstIteration=${isFirstIteration}" \
    "first_and_last_url_were_matching_only_in_first_iteration=${first_and_last_url_were_matching_only_in_first_iteration}" \
    "last_and_first_url_are_different=${last_and_first_url_are_different}"
  
  # Open the browser
  browser_main_activity="mark.via.gp/mark.via.Shell"
  adb shell am start -W ${browser_main_activity}
  sleep 4
  
  # Mark URL in address bar
  adb shell input touchscreen tap 360 100
  sleep 2
  
  # Cut the URL
  adb shell input touchscreen swipe 360 100 360 100 2000
  sleep 2
  adb shell input touchscreen tap 360 200
  sleep 2

  # Go back to the page
  adb shell input touchscreen tap 360 640
  sleep 2

  # Open the text editor
  adb shell am start -W com.rhmsoft.edit.pro/com.rhmsoft.edit.activity.MainActivity
  sleep 1

  # Open the 'Edit' menu - the 'pencil' icon
  adb shell input touchscreen tap 575 90
  sleep 1

  # 'Paste' the URL into the text editor
  adb shell input touchscreen tap 575 390
  sleep 1

  # Enter a new line to separate URLs
  adb shell input keyevent KEYCODE_ENTER

  # Open the 'File' menu - the 'folder' icon
  adb shell input touchscreen tap 475 90
  sleep 1

  # 'Save' the file
  adb shell input touchscreen tap 475 390
  sleep 1
  
  # Compare last line of file with current URL to decide whether to stop the backup
  tabs_file_path='/sdcard/tabs.txt'
  last_url="$(adb shell cat "${tabs_file_path}" | tail -n 1)"

  first_url="$(adb shell cat "${tabs_file_path}" | head -n 1)"
  test "${last_url}" != "${first_url}"
  last_and_first_url_are_different=$?

  # Continue backing up/iterating through the rest of the tabs after the first
  if [ "${isFirstIteration}" = "1" ] && [ "${first_and_last_url_were_matching_only_in_first_iteration}" = "0" ]
  then
    first_and_last_url_were_matching_only_in_first_iteration="1"
  fi

  # Continue backing up/iterating through tabs even though the URLs are matching
  if [ "${isFirstIteration}" = "0" ]
  then
    isFirstIteration="1"
    first_and_last_url_were_matching_only_in_first_iteration="0"
  fi

  # Go back to the browser
  adb shell am start -W ${browser_main_activity}
  sleep 2

  # Go to the next tab
  adb shell input touchscreen swipe 575 1140 275 1140 600
  sleep 4
done

echo "DEBUG: press any key to continue with post-processing"
read -r

printf "%s\n" "Done."
printf "%s%s\n" "The tabs have been saved to: " "${tabs_file_path}"

# FOR DEBUGGING PURPOSES
tabs_file_path='/sdcard/tabs.txt'

adb pull "${tabs_file_path}" "/tmp/tabs.txt"

# Remove last duplicate URL
head --lines=-1 "/tmp/tabs.txt" > "/tmp/tabs-new.txt"

# Insert an empty new line in between each line with link for easier readability
sed -e 'G' "/tmp/tabs-new.txt" > "/tmp/tabs.txt"

# Push the tabs file back to the phone
adb push "/tmp/tabs.txt" "${tabs_file_path}"

