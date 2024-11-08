# Android_tutorials

Tutorials for Android

## Connect phone via wireless ADB connection

1. Phone: Enable Dev Options
1. Phone: Enable Wireless ADB
1. Phone: Open Wireless ADB
1. Phone: Click on Pair via Code
1. PC: Install adb tools, open terminal and pair with the phone with command

    ```
    adb pair 192.168.60.252:43061
    ```

    where the values are matching the values displayed in the pairing prompt on the phone.

    When prompted, enter the pairing code to the terminal and press Enter.

1. Phone: close the pairing prompt and check the connection in option IP address & Port
1. PC: use the connection from the phone to establish wireless connection

    ```
    adb connect 192.168.60.252:40677
    ```

### Sources

- https://www.youtube.com/results?search_query=adb+wireless
- https://www.youtube.com/watch?v=_JjpbufTMew

## Copy file between the phone and the computer

Limitations of MTP storage - can't modify files in place - in the MTP storage directly  
Source: Can't write text file to android sd card through mtp protocol - https://forums.linuxmint.com/viewtopic.php?p=1369918#p1369918

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

    - **Backup phone**

            adb pull /storage/sdcard0/. "${HOME}/backup-smartphone/Phone/"

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

## Speed up Android

- LagFix Game Booster - (fstrim) Trimmer
  - no root
- Greenify
- Droid Optimitzer

Maybe DNS Changer, for faster internet browsing, but I already use NetGuard to block ads in my Android apps and I'm not sure I'm willing to switch back and forth to disable NetGuard, enable DNS Changer when browsing Internet, and then enable NetGuard, disable DNS Changer to do everything else.

Sources:

- https://cybergeekin.blogspot.com/2015/04/why-do-android-phones-lag-rootnon.html
- https://duckduckgo.com/?q=lagfix+no+root&ia=web
- https://forum.xda-developers.com/search/36173701/?q=lagfix&o=relevance
- https://duckduckgo.com/?q=best+game+booster+apps+android&ia=web
- https://techigem.com/game-booster-apps/
- https://duckduckgo.com/?q=dns+server+list+benchmark&ia=web
- https://www.serverwatch.com/server-reviews/dns-benchmark-tools/
- https://www.dnsperf.com/#!dns-providers,Europe
- https://duckduckgo.com/?q=Sectigo+dns+ips&ia=web
- https://public-dns.info/nameserver/sk.html
- https://duckduckgo.com/?q=Exoscale+DNS+ip&ia=web
- http://www.dnscheck.pro/exoscale.com
  - United States ns1.exoscale.ch. → 162.159.25.4
  - United States ns1.exoscale.com. → 162.159.27.4
  - United States ns1.exoscale.io. → 162.159.24.4
  - United States ns1.exoscale.net. → 162.159.26.4
- https://ns.tools/exoscale.ch
- https://dnslytics.com/ip/185.19.31.244
  - ns2.exoscale.net → 185.19.31.244
- https://www.grc.com/dns/benchmark.htm
- https://play.google.com/store/apps/details?id=com.burakgon.dnschanger&hl=en_US&gl=US

