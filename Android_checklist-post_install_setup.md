1. Prejst uvodnymi nastaveniami Androidu po prvom spustení
    - Google ucet
    - Google assistant - ovladanie hlasom
    - Google pay
    - Pridat odtlacky prstov
    - \[Voliteľné\] Nainstalovat programy od vyrobcu
    - Aktivovat ovladanie gestami - viac miesta pre zobrazovanie aplikácii
1. Update all apps from Google Play Store
1. Settings
    1. Install all android updates: `Systemupdates` click on `Check for updates`; Download and apply update; Restart when prompted.
    1. Install Google Play updates: About -> Android Version -> Google Play Updates
    1. Install Stylus firmware updates: `Stylus -> Check for updates`. Enable bluetooth when prompted.
    1. Battery -> enable "Battery percentage"
    1. Network
        - Mobile network
            - Mobil data warning: 150 MB
            - Mobile data limit: 180 MB
        - Enable `Restrict mobile data`/`Datensparmodus` to reduce the amount of data when connected to the internet via the provider's mobile network
    1. Play music streams even when minimized and with screen off: Apps -> Chrome/Vivaldi -> Battery -> Unrestricted/Unoptimized
        - Browsers like `Via Browser`, `Pure Browser` (and maybe other similar browsers) don't play music in background from Soundcloud even when set to `Unrestricted`/`Unoptimized` battery mode - the playback stops regardless after a while
    1. Quietly show Google Fit notifications - let the app show notification but without acoustic distraction: Apps -> Google Fit -> Notifications
        - Reached goals -> Silent
        - Goal progress -> Silent
    1. Tone & Vibration
        - Dolby Atmos -> Settings -> Smart Audio
            - With this settings the music playback can contain cracking, noise, echo, hum, buzz or other distortions and audio artefacts: just let it play for a minute or two and the AI will learn and fixes it by itself.
        - Ringtone
            - SIM 1: Xperia (copied from my Sony Xperia XA1 G3121)
            - SIM 2: Orion (copied from my Sony Xperia XA1 G3121)
        - Enable per app volume setting in `Multi Volume`
            - enables setting the volume via the notification bar, when playing media
        - Media
            - `Fix media player`: enabled
            - `Show media recommendation`: disabled
        - `Vibrate on call`: always
        - `Dial pad tones`: disabled
        - `Lock screen sount`: enabled
        - `Sound and vibration when charging`: disabled
        - `Touch sounds`: disabled
        - `Haptic feedback`: disabled
        - `Startup sound`/`Töne beim hochfahren`: disabled
    1. Display
        - Lockscreen
            - Privacy: Don't show any notifications (bigger clock) / Show sensitive content only in unlocked mode (smaller clock)
            - Lockscreen text: <emailova.adresa@provider.domena>
                - in case of loss
            - hide the wallet icon by disabling
        - Night light: always enabled with approx. 50% intensity
        - Enable Vorschaudisplay/Always-On-Display to check time and battery charge without pressing the power button when the phone is locked to reduce the usage of hardware
            - Settings: disable `Animated background`
    1. Privacy/Datenschutz
        - Enable location history as a help at searching for the phone when it gets lost: Google Location history/Google-Standortverlauf -> Activate
    1. System
        - Fix time on folio display, i.e. make it fit to one line for the Folio case cutout area - this happens when all four numbers in time are non-ones i.e. `0` or `2-9`. Go to `Date & Time`:
            - `Use standard format for chosen language`: disabled
            - `Use 24 hour format`: disabled - this setting changes the 24-hour time to 12-hour time format in English speaking countries: ommitting the leading `0` when it's `0-9` o'clock
    1. Aktivácia Developer options: About Phone, Software information, 10x klik Build number
        1. Na presun súborov používať `adb` utilitku, ktorá potrebuje mať zapnutý `USB Debugging` v `Developer options`
        - Pre zvýšenie bezpečnosti, vždy povoľovať ADB prístup jednorázovo bez zapamätania zariadenia, a po každom použití `USB Debugging` vypnúť.
    1. Deaktivácia efektov prechodu/animácii
        - Bez aktivácie Developer options cez zjednodušenie prístupu: Accessibility -> Text and Appearance -> Disable/Remove animations
        - Developer options -> Drawing, vypnúť/nastaviť a 0 položky Window animation scale, Transition animation scale a Animation duration scale
    1. Ak DNS resolvuje pomaly alebo občas vôbec: enter "private dns" in the settings search bar -> enter without quotes "dns.google"
    1. nastavit cierne pozadie obrazovky a zamku obrazovky - setrenie baterie
    1. zvysit citlivost obrazovky, aby reagovala na dotyk cez rukavicu: Display -> Increase touch sensitivity
1. Apps
    1. Restore SMS and call history with `SMS Backup & Restore`
    1. Install firewall app - e.g. `Netguard` - to block internet access to block ads in apps that we don't mind to be offline
        - At first, it failed: I couldn't enable firewall because another app had already used the VPN connection. I hadn't found out, which one it was. After a week or two, I installed Netguard again, enabled it, and it finally enables without any error messages.
        - Disable internet access via mobile internet and Wi-Fi for specific apps to block ads without buying a paid version of the app and to increase privacy.
    1. `Accubattery`, nastavit také %, aby telefón vydržal celý deň a nevybil sa pod 20%
        - po nainštalovaní vypneme % batérie v `Battery -> Battery percentage` lebo Accubattery ukazuje percentá batérie v ikone v notifikačnej lište
        - AccuBattery notification sound by setting Sound to luXury and Vibrations set to enabled
    1. Authenticate banking app - add new device
    1. Authenticate "EU Login Mobile" app for Europass portal - 2-Factor Authentication - add new device
    1. Aunthenticate mobility apps: Bolt, Bike KIA
    1. Authenticate the rest of the apps with login requirement
    1. Install a lightweight launcher: Lawnchair/LeanLaunch
        - set it as default launcher in `Apps -> Default apps -> Start-App/Launcher`
    1. Turn off suggested apps: long press on empty space on home screen -> Home settings -> Home screen style -> click on the 'gear' icon next to the `App tray` option -> disable all `Suggested` options
    1. Set custom WhatsApp sound: three dots -> Settings -> Notifications
        - Chat sound: Pixie Dust
        - Group Chat sound: Pixie Dust
    1. Install an app for running the `TRIM` command e.g. `mFSTRIM`
        - App and explanation: https://forum.xda-developers.com/t/mfstrim-a-real-foss-fstrim-utility-for-android-no-root-necessary.4258765/
    1. Navigation
        - Locus - outdoor/trekking navigation
        - Sygic - road navigation: with detailed crossroad view
    1. Macrodroid
        - for customization of the system, e.g. when the charger gets connected or disconnected
        - pridat don skripty pre vlastne zvuky pripojenia a odpojenie nabijacky a sledovanie nabitia baterie podobne ako AccuBattery (len sa mi nepacia tie zvuky, tak som ich vypol pre nabijanie v systeme a pre AccuBattery som nechal iba notifikacie s vibraciou bez zvuku)
        - Set Macrodroid Macro notification sound for regular and high priority notifications to Silent to enable the usage of custom notification sounds and custom vibrations for each notification in each macro: Apps -> Macrodroid -> Notifications -> Notification action/Benachrichtigungsaktion -> Standard; Sound: None; Vibrations: enabled
            - to accompany the notification with a sound, place the action `Media -> Play/Pause media` after each `Show notification` action
            - for notification vibration, add the action `Device actions -> Vibrate`
        - aktivovat MacroDroid notifikacie aj pri v rezime Nerusit: TODO DOPLNIT KROKY
    1. Anatomy apps
        - Anatomy: `com.ssstudio.anatomypronoads`
        - Human Anatomy Atlas (2021.2.27): `com.visiblebody.atlas` (source: moddroid: ALL IN ONE apk)
        - Essential Anatomy 3 (v1.1.3): `com.the3d4medical.EssentialAnatomy` (source: apkarchive.com)
    1. - turistika
        - **Locus Maps**
        - maps.me
        - peak finder
    1. Uninstall/Disable bloatware
        - Deactivate app `Dolby Atmos` - prevention against sound cracking and popping, assuring premium sound quality
    1. mute Moto Notes notifications for removed stylus: Notifications -> App settings -> Moto Notes -> Stylus gone/away: Silent + enable Minimize
    1. nastavit Unpotimized/Untestricted battery mode pre AccuBattery, MacroDroid, Google Fit, Clock (aby budiky zvonili a zvonili nahlas), Gmail, SMS Backup & Restore (aby notifikacie chodili a appky robili pravidelne planovane nacasovane zalohy), Screen Off & Lock, chatovacie appky: WhatsApp, Signal, Viber?, Messenger? lebo pri rezime uspory energie tieto appky killuje
