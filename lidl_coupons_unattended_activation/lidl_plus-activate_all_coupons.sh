#!/bin/sh

set -x

echo "=============================================="
echo "DISABLE ANY BLUE LIGHT FILTER"
echo "IN ORDER TO HAVE ACCURATE COLOR REPRESENTATION"
echo "WHAT THIS SCRIPT RELIES UPON"
echo "OTHERWISE IT MAY NOT FUNCTION PROPERLY"
echo "=============================================="

# Launch Lidl Plus
#  Find out 'the package_name/application_intent_or_activity' with 'adb logcat > ~/logcat.log'
#  and then opening the file in a text editor, e.g. 'less ~/logcat.log' 
#  and searching for keywords that the app consists of

adb shell am start -W com.lidl.eci.lidlplus/es.lidlplus.i18n.splash.presentation.view.SplashActivity

sleep 10

# Go to tab 'Kupóny'

adb shell input touchscreen tap 215 1215

sleep 5

# Go to the end of the coupons list

adb shell input touchscreen swipe 0 1165 0 -100000 5000

# Activate the last coupon by opening it (regardless of its state: activated, deactivated or locked)

adb shell input touchscreen tap 640 813
#adb shell input touchscreen swipe 640 813 640 813 3000

sleep 2

# If necessary, confirm the dialog windows by clicking on the 'Rozumiem' button
# When the dialog window is not displayed, the 'Letáky' tab will be activated

adb shell input touchscreen tap 360 1195
#adb shell input touchscreen swipe 360 1195 360 1195 3000

sleep 5

# If the 'Letáky' tab had been activated, or the coupon had been opened, go back to the coupons list

adb shell input keyevent KEYCODE_ESCAPE

sleep 3

adb shell input touchscreen tap 215 1215

sleep 3

# Go to the end of the coupons list - again

adb shell input touchscreen swipe 0 1165 0 -100000 5000

# Activate all coupons

screenshot_number=0
difference_between_screenshots="100000000"

while true
do
  # adjust image name to fix sorting when reaching two digits
  screenshot_number_string="$(seq --equal-width $screenshot_number 99 | head -n 1)"

  # make screenshot
  adb exec-out screencap -p > "/tmp/screenshot-phone-435-${screenshot_number_string}.png"

  # strip the status bar before comparing last and curent screenshot, 
  #  in order to prevent the clock or battery percentage/indicator 
  #  or notifications to change the output of the comparison of possibly almost identical images
  convert -crop 720x230+0+50 "/tmp/screenshot-phone-435-${screenshot_number_string}.png" "/tmp/screenshot-phone-435-${screenshot_number_string}-without_statusbar.png"
  
  previous_screenshot_number=$(( screenshot_number - 1 ))
  previous_screenshot_number_string="$(seq --equal-width $previous_screenshot_number 99 | head -n 1)"
  if     [ -f "/tmp/screenshot-phone-435-${previous_screenshot_number_string}-without_statusbar.png" ] \
      && [ -f "/tmp/screenshot-phone-435-${screenshot_number_string}-without_statusbar.png" ]
  then
    difference_between_screenshots="$(magick compare -metric AE "/tmp/screenshot-phone-435-${previous_screenshot_number_string}-without_statusbar.png" "/tmp/screenshot-phone-435-${screenshot_number_string}-without_statusbar.png" "/tmp/diff.png" 2>&1)"
  fi
  
  # Wait - for debugging purposes
  #sleep 5

  if [ ${difference_between_screenshots} -le 10000 ]
  then
    exit
  fi

  # Wait - for debugging purposes
  #sleep 3

  # click the button: find the area; check color of deactivated or locked coupon; activate coupon if deactivated; go to the next coupon when current coupon is marked as locked

  begin_y=913
  offset=0

  while true
  do
    y_coordinate=$(( begin_y - offset ))
    color="$(magick "/tmp/screenshot-phone-435-${screenshot_number_string}.png" -format "%[hex:u.p{640,${y_coordinate}}]\n" info:)"

    # if we find locked coupon
    if [ "${color}" = "00000000" ]
    then
      break
    fi

    # if the outer edge of the activation button is reached
    if [ "${color}" = "0050AA00" ]
    then
      inner_y_coordinate=$(( y_coordinate - 20 ))  # set y coordinate to the inside of the activation button
      inner_color="$(magick "/tmp/screenshot-phone-435-${screenshot_number_string}.png" -format "%[hex:u.p{640,${inner_y_coordinate}}]\n" info:)"

      # Wait - for debugging purposes
      #sleep 5

      # if the coupon is deactivated
      if [ "${inner_color}" = "0050AA00" ]
      then
        # open coupon
        #adb shell input touchscreen swipe 640 $(( y_coordinate - 100 )) 640 $(( y_coordinate - 100 )) 3000

        # activate the coupon
        #adb shell input touchscreen swipe 640 ${inner_y_coordinate} 640 ${inner_y_coordinate} 5000
        adb shell input touchscreen tap 640 ${inner_y_coordinate}

        sleep 3
        
        #adb shell input touchscreen swipe 675 830 675 830 3000
        # TODO make two screenshots
        # TODO glue the screenshots together
        # TODO extract text from the screenshots
        # TODO parse extracted text to form a valid special offer item
        #
        # go back to the list of coupons
        #adb shell input keyevent KEYCODE_BACK
        
        #sleep 4

        break
      fi

      # if the coupon is activated
      if [ "${inner_color}" = "FFFFFFFF" ]
      then
        # open coupon
        #adb shell input touchscreen swipe 640 $(( y_coordinate - 100 )) 640 $(( y_coordinate - 100 )) 3000

        #sleep 5

        # TODO make two screenshots
        # TODO glue the screenshots together
        # TODO extract text from the screenshots
        # TODO parse extracted text to form a valid special offer item
        #
        # go back to the list of coupons
        #adb shell input keyevent KEYCODE_BACK

        #sleep 5

        break
      fi
    fi

    offset=$(( offset + 1 ))
  done

  adb shell input touchscreen swipe 0 500 0 935 2000

  screenshot_number=$(( screenshot_number + 1 ))
done

# TEST 8 - 434 - 1 = 433
#
# 

# TEST 7 - 435 - 1 = 434
#
# LOWEST DEVIANCE! CHOOSING...

# TEST 6 - 436 - 1 = 435
#
# EVEN EVEN BETTER???

# TEST 5 - 437 - 1 = 436
#
# EVEN BETTER???

# TEST 4 - 434 + 3 = 437
#
# OK?

# TEST 3 - 438 - 4 = 434
#
# 913 - 910 = 3

# TEST 2 - 425 + 13 = 438
#
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-0.png" -format "%[hex:u.p{640,913}]\n" info:
#80285580
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-0.png" -format "%[hex:u.p{640,912}]\n" info:
#80285580
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-0.png" -format "%[hex:u.p{640,914}]\n" info:
#EA6A6AEA
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-0.png" -format "%[hex:u.p{640,913}]\n" info:
#80285580
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-1.png" -format "%[hex:u.p{640,913}]\n" info:
#80285580
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-1.png" -format "%[hex:u.p{640,917}]\n" info:
#80285580
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-1.png" -format "%[hex:u.p{640,916}]\n" info:
#80285580
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-438-1.png" -format "%[hex:u.p{640,918}]\n" info:
#EA6A6AEA
#[laptop@laptop Downloads]$ echo $(( 917 - 913))
#4

# TEST 1 - 425
#
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-425-0.png" -format "%[hex:u.p{640,913}]\n" info:
#80285580
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-425-1.png" -format "%[hex:u.p{640,913}]\n" info:
#FF7F7FFF
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-425-1.png" -format "%[hex:u.p{640,914}]\n" info:
#FF7F7FFF
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-425-1.png" -format "%[hex:u.p{640,915}]\n" info:
#FF7F7FFF
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-425-1.png" -format "%[hex:u.p{640,901}]\n" info:
#EB6B6BEB
#[laptop@laptop Downloads]$ magick "${HOME}/screenshot-phone-425-1.png" -format "%[hex:u.p{640,900}]\n" info:
#80285580
#[laptop@laptop Downloads]$ echo $(( 425 + 13 ))
#438