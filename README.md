# Android_tutorials

Tutorials for Android

## Copy file between the phone and the computer

- phone `->` PC

    - copy file

            adb pull /storage/extSdCard/buffer.txt /tmp/buffer.txt

    - copy multiple files using a wildcard from phone to PC

            adb shell "ls /storage/extSdCard/DCIM/Camera/20211224_0*" | tr -d '\r' | xargs -n1 adb pull

        or

            adb shell "ls /storage/extSdCard/DCIM/Camera/20211224_0*" | tr '\r' ' ' | xargs -n1 adb pull

        - Sources:
            - https://stackoverflow.com/questions/11074671/adb-pull-multiple-files/11250068#11250068
            - https://stackoverflow.com/questions/11074671/adb-pull-multiple-files/37122195#37122195

    - copy a directory recursively, i.e. with all files in the subdirectories

            adb pull /storage/sdcard0/Locus/mapsVector/europe/. .

        Source: https://android.stackexchange.com/questions/87326/recursive-adb-pull/87327#87327

-PC `->` phone

    adb push /tmp/buffer.txt /storage/extSdCard/buffer.txt
    adb push Locus/. /storage/sdcard0/

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

