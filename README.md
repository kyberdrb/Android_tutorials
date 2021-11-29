# Android_tutorials

Tutorials for Android

## Backup entire phone through ADB recursively

    # Sony Xperia XA1 - internal storage
    adb pull /storage/sdcard0/. .
    
    # Samsung Galaxy J3 - internal storage
    TODO
    
    # Samsung Galaxy J3 - SD card
    TODO

Source: https://android.stackexchange.com/questions/87326/recursive-adb-pull/87327#87327

## Shorten all times for Impetus session

    cat /home/laptop/backup-samsung_j3/Card/impetus/Druckmassage-schnell.xml | sed 's/time="[90000|120000|180000]"/time="60000"/g'

## Block ads in apps

. Install NetFilter
. Configure NetFilter for each app that you want to restrict internet access
. Test whether the app still functions correctly

Source: https://www.infopackets.com/news/10334/how-use-firewall-block-full-screen-ads-android

