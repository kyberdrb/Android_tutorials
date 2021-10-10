 Backup and Restore Android Apps

# Usage

Both scripts use a backup directory to save and restore android packages

Examples

Backup

  ./backup_apps.sh ~/backup-samsung_j3/apps_and_data/
  ./backup_apps.sh ~/backup-samsung_j3/apps_and_data/ --with-data

Backup check: `ls ~/backup-samsung_j3/apps_and_data/`

Restore (Not tested)

  ./restore_apps.sh ~/backup-samsung_j3/apps_and_data/
  ./restore_apps.sh ~/backup-samsung_j3/apps_and_data/ --with-data

Data recovery doesn't work even on either of my phones even with the same firmware, therefore I made data backup and restoration optional. Maybe it will proove useful to someone

# Sources

- https://gist.github.com/AnatomicJC/e773dd55ae60ab0b2d6dd2351eb977c1
- https://stackoverflow.com/questions/15014519/apk-installation-failed-install-failed-verification-failure/34666037#34666037
- https://stackoverflow.com/questions/34951901/percent-symbol-in-bash-whats-it-used-for/34952009#34952009
- https://androidfilebox.com/tips/how-to-backup-phone-data-without-root-and-unlocking-bootloader/
- https://stackoverflow.com/questions/53634246/android-get-all-installed-packages-using-adb#53634311
- https://stackpointer.io/mobile/android-adb-list-installed-package-names/416/
- https://stackoverflow.com/questions/53289998/adb-backup-location-of-the-resulting-file/53297973#53297973
- https://stackoverflow.com/questions/24219287/adb-pull-file-in-a-specific-folder-of-pc/24219661#24219661
