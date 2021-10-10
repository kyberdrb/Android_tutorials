#!/bin/sh

APPS_DIR="$1"

RESTORE_WITH_DATA="$2"

cd "${APPS_DIR}"

adb shell settings put global verifier_verify_adb_installs 0

# Not necessary but may help when there are still problems with 
#adb shell settings put global package_verifier_enable 0

for package_file in $(ls *.apk)
do
  package_name="${package_file%.apk}"
  adb uninstall "${package_name}"
  adb install "${package_file}"
  
  if [ "${RESTORE_WITH_DATA}" = "--with-data" ]
  then 
    adb restore "${package_name}.data"
  fi
  
  echo
  echo "----------------------------------------------------------"
  echo
done

