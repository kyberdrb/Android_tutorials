#!/bin/sh

DESTINATION_DIR="$1"

BACKUP_WITH_DATA="$2"

cd "${DESTINATION_DIR}"

# 'cmd' for 'adb shell' is unsupported for Samsung Galaxy J3 Dual SIM 2016 (Android 5.0.0 - Marshmallow); using 'pm' instead
#for app in $(adb shell cmd package list packages -f -3)

for app in $(adb shell pm list packages -f -3)
do
  package_info="$(echo "${app}" | sed "s/^package://")"
  package_file_absolute_path_without_extension=$(echo ${package_info%\.apk=*})
  package_file_absolute_path_with_extension="${package_file_absolute_path_without_extension}.apk"

  package_name="$(echo "${app}" | sed "s/^package://" | sed "s/=/ /g" | cut -d' ' -f4 | tr -d '\r')"

  echo "package info: ${package_info}"
  echo "package file absolute path with extension: ${package_file_absolute_path_with_extension}"
  echo "apk package name: ${package_name}"

  adb pull "${package_file_absolute_path_with_extension}" "${package_name}"

  #echo "destination data name for package: ${destination_data_name_for_package}"

  # TODO test data backup with a single package first, then scriptify - I'm not sure the data backup will work
  #if [ "${BACKUP_WITH_DATA}" = "--with-data" ]
  #then 
  #  destination_data_name_for_package="${package_name}.data"
  #  adb backup -f "${destination_data_name_for_package}" -apk "${package_name}"
  #fi

  echo
  echo "----------------------------------------------------------"
  echo
done

