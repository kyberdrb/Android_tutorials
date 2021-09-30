#!/bin/sh

DESTINATION_DIR="$1"

cd ${DESTINATION_DIR}

adb shell settings put global verifier_verify_adb_installs 0

# Not necessary but may help when there are still problems with 
#adb shell settings put global package_verifier_enable 0

for package_file in $(ls *.apk)
do
  package_name="${package_file%.apk}"
  adb uninstall "${package_name}"
  adb install "${package_file}"
  
  # TODO make data restoration optional, but disabled by default, for speed of the backup and to prevent app crashes
  #adb restore "${package_name}.data"
  
  echo
  echo "----------------------------------------------------------"
  echo
done

