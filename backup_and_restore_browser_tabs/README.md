# Backup and restore tabs in browser in Android

# Designed for:
#   - Sony Xperia XA1 (G3121),
#   - 720x1280 resolution (HD),
#   - Via browser (by Tu Yafeng) and
#   - QuickEdit+ v1.8.4 (the paid version)

## Usage for backing up tabs

1. Connect the Android phone to the computer.  
    Make sure the **USB Debugging** is enabled.

1. [VIA BROWSER ONLY] Open Via browser and click on the first tab (in the first group if you have groupped tabs) or the tab you want to start the backup from.  
    1. Make sure the 'Mobile' client is activated (e.g. for faster loading times for 'Youtube' for example.
    1. Click in the address bar to activate the text in it, then press the 'BACK' key t show the page
1. Delete all contents of the file "tabs.txt" stored in the internal phone memory for the text editor
1. Check there aren't any duplicate tabs, i.e. all tabs in the browser have their unique URL - equality of the URLs is the stopping condition
1. Launch the backup script
    1. For **Via Browser**

            ./backup_tabs-Via_browser_by_Tu_Yafeng.sh 

    1. For **Vivaldi** and **Brave**

            ./backup_tabs.sh

## Usage for restoring tabs

1. Connect the Android phone to the computer.  
    Make sure the **USB Debugging** is enabled.
1. [VIA BROWSER ONLY] Open Via browser on the tab you want to start the restorationg from - usually the first new/empty tab
1. [VIVALDI/BRAVE ONLY] Open Vivaldi browser at blank tab overview, i.e. without tabs but one [because Vivaldi opens quick launch tab immediately after closing the last tab] - disable 'Show tab list' - then minimize the browser
1. Launch the restoration script 
    1. For **Via Browser**

            ./restore_tabs-Via_browser_by_Tu_Yafeng.sh 

    1. For **Vivaldi** and **Brave**

            ./restore_tab.sh <URL>

## How to start an app in Android through `adb`?

An Android application can be started via `adb` with command `adb shell am start -W <INTENT_NAME>`, where the `<INTENT_NAME>` can be found by capturing a list of events with `logcat` and then reviewing it.
 
The name of the web browser Intent and its Main activity can be found with these commands:

1. Start logging, open the web browser on Android phone, then immediately stop the logging with `Ctrl + C` to keep the log as short as possible for easier navigation.

        adb logcat > logcat.log

1. Open the log

        less logcat.log

1. Press `/` (forward slash) to enable searching
1. Enter `via`
1. Press `n` for next result (or `Shift + N` for previous result) to find the starting of the Main Activity/main Intent of the web browser. Below I show the snipped of the output I got:
   
             08-31 12:06:01.181   936  6510 I ActivityManager: START u0 {act=android.intent.action.MAIN cat=[android.intent.category.LAUNCHER] flg=0x10200000 cmp=mark.via.gp/mark.via.Shell bnds=[132,977][208,1148]} from uid 10212
             08-31 12:06:01.225   936  6510 I ActivityManager: Start proc 16169:mark.via.gp/u0a198 for activity mark.via.gp/mark.via.Shell
             08-31 12:06:02.437   936  6510 I WindowManager: Relayout Window{3048fe u0 mark.via.gp/mark.via.Shell}: oldVis=4 newVis=0 focusMayChange = true
   
1. After you found the name of the activity or intent of the application you're looking for, copy it and use it in place of the `<INTENT_NAME>` to test the app launch with `adb`
1. Press 'q' to exit `less`

## Sources

Backup
- https://duckduckgo.com/?q=gesture+automate+android+adb&ia=web
- https://stackoverflow.com/questions/3437686/how-to-use-adb-to-send-touch-events-to-device-using-sendevent-command
- https://duckduckgo.com/?q=adb+gesture&ia=web&iax=qa
- https://stackoverflow.com/questions/39595431/some-swipe-gesture-with-adb-input/39595726#39595726
- https://stackoverflow.com/questions/4567904/how-to-start-an-application-using-android-adb-tools#4567928
- https://duckduckgo.com/?q=adb+show+intents+from+apk&ia=web&iax=qa
- https://sodocumentation.net/adb/topic/4252/showing-logs-on-adb
- All Android Key Events for usage with adb shell: https://gist.github.com/arjunv/2bbcca9a1a1c127749f8dcb6d36fb0bc
- https://duckduckgo.com/?q=adb+press+back+button&ia=web&iax=qa
- https://unix.stackexchange.com/questions/314486/shell-logical-not#314497
- https://stackoverflow.com/questions/3924182/how-does-the-keyword-if-test-if-a-value-is-true-or-false
- https://stackoverflow.com/questions/13542832/difference-between-single-and-double-square-brackets-in-bash
- https://stackoverflow.com/questions/3826425/how-to-represent-multiple-conditions-in-a-shell-if-statement
- https://duckduckgo.com/?q=posix+shell+compound+conditions+example&ia=web
- https://stackoverflow.com/questions/65514753/negate-a-boolean-variable-and-assign-it-to-a-new-variable
- https://duckduckgo.com/?q=delete+blank+lines+sed&ia=web
- https://unix.stackexchange.com/questions/207835/how-to-insert-multiple-blank-lines-after-every-line

Restoration

- https://unix.stackexchange.com/questions/7011/how-to-loop-over-the-lines-of-a-file/670789#670789
- https://developer.android.com/reference/android/view/KeyEvent
- https://stackoverflow.com/questions/7789826/adb-shell-input-events
- https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-xp/bb490982(v=technet.10)?redirectedfrom=MSDN
- https://duckduckgo.com/?q=sed+remove+empty+lines&ia=web
- https://duckduckgo.com/?q=remove+%5Cr+character+from+variable+bash&ia=web
- https://superuser.com/questions/489180/remove-r-from-echoing-out-in-bash-script#489191
- `info sed`

