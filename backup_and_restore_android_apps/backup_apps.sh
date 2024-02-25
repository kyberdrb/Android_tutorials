#!/bin/sh

set -x

DESTINATION_DIR="$1"

BACKUP_WITH_DATA="$2"

mkdir --parent "${DESTINATION_DIR}"

adb devices

echo "Back up app names"
adb shell pm list packages -f -3 | rev | cut --delimiter='=' --fields=1 | rev > "${DESTINATION_DIR}apps-list.txt"

# 'cmd' for 'adb shell' is unsupported for Samsung Galaxy J3 Dual SIM 2016 (Android 5.0.0 - Marshmallow); using 'pm' instead
#for app in $(adb shell cmd package list packages -f -3)

# Back up app files - optionalize
#for app in $(adb shell pm list packages -f -3)
#do
#  package_info="$(echo "${app}" | sed "s/^package://")"
#  package_file_absolute_path_without_extension=$(echo ${package_info%\.apk=*})
#  package_file_absolute_path_with_extension="${package_file_absolute_path_without_extension}.apk"
#
#  package_name="$(echo ${package_info##*=} | tr -d '\r')"
#
#  echo "package info: ${package_info}"
#  echo "package file absolute path with extension: ${package_file_absolute_path_with_extension}"
#  echo "apk package name: ${package_name}"
#
#  adb pull "${package_file_absolute_path_with_extension}" "${DESTINATION_DIR%/}/${package_name}.apk"
#
#  if [ "$?" -ne 0 ]
#  then
#    echo "Standard backup procedure failed"
#    echo "Trying alternative procedure..."
#
#    # Found intersecting match between Samsung Galaxy J3 and Sony Xperia XA1 in directories for internal storage:
#    # - adb shell ls /mnt/sdcard/
#    # - adb shell ls /sdcard/
#    # - adb shell ls /storage/sdcard0/
#    # I chose the '/sdcard/' path for internal storage, because it was the shortest
#
#    adb shell cp ${package_file_absolute_path_with_extension} "/sdcard/${package_name}.apk"
#    adb pull "/sdcard/${package_name}.apk" "${DESTINATION_DIR%/}/"
#    adb shell rm "/sdcard/${package_name}.apk"
#  fi
#
#  echo "package destination: "${DESTINATION_DIR%/}/${package_name}.apk""
#
#  #echo "destination data name for package: ${destination_data_name_for_package}"
#
#  # TODO test data backup with a single package first, then scriptify - I'm not sure the data backup will work
#  #if [ "${BACKUP_WITH_DATA}" = "--with-data" ]
#  #then
#  #  destination_data_name_for_package="${package_name}.data"
#  #  adb backup -f "${destination_data_name_for_package}" -apk "${package_name}"
#  #fi
#
#  echo
#  echo "----------------------------------------------------------"
#  echo
#done

