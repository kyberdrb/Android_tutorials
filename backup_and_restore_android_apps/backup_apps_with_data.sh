#!/bin/sh

DESTINATION_DIR="$1"

cd ${DESTINATION_DIR}

# 'cmd' for 'adb shell' is unsupported for Samsung Galaxy J3 Dual SIM 2016; using 'pm' instead
#for app in $(adb shell cmd package list packages -f -3)

for app in $(adb shell pm list packages -f -3)
do
  apk_package_file="$(echo "${app}" | sed "s/^package://" | sed "s/=/ /" | cut -d' ' -f1 | tr -d '\r')"
  apk_package_name="$(echo "${app}" | sed "s/^package://" | sed "s/=/ /" | cut -d' ' -f2 | tr -d '\r')"
  
  destination_apk_package_name="${apk_package_name}".apk
  destination_data_name_for_package="${apk_package_name}".data

  echo "apk package file: ${apk_package_file}"
  echo "destination apk package name: ${destination_apk_package_name}"
  echo "destination data name for package: ${destination_data_name_for_package}"
  echo "apk package name: ${apk_package_name}"

  adb pull "${apk_package_file}" "${destination_apk_package_name}"

  # TODO make data backup optional and disabled by default
  #adb backup -f "${destination_data_name_for_package}" -apk "${apk_package_name}"

  echo
  echo "----------------------------------------------------------"
  echo
done

