#!/bin/sh

adb devices | tail --lines=+2 | head --lines=1

echo "Backing up apps"
echo ""
gio trash "${HOME}/backup-moto_edge_30_pro/apps/"
mkdir --parents "${HOME}/backup-moto_edge_30_pro/apps/"
date && time "${HOME}/git/kyberdrb/Android_tutorials/backup_and_restore_android_apps/backup_apps.sh" "${HOME}/backup-moto_edge_30_pro/apps/" && date

echo "Backing up files"
echo ""
gio trash "${HOME}/backup-moto_edge_30_pro/Phone-complete/"
mkdir --parents "${HOME}/backup-moto_edge_30_pro/Phone-complete/"
 
date && time adb shell "find /sdcard/ -maxdepth 1 -type f" | grep --invert-match "^Android$" | sort | xargs -d $'\n' sh -c 'for arg do echo "Backing up "$arg""; adb pull "$arg" "${HOME}/backup-moto_edge_30_pro/Phone-complete/";  echo ""; done' _ && date
 
date && time adb shell "find /sdcard/ -maxdepth 1 -mindepth 1 -type d" | grep --invert-match "Android$" | sort | xargs -d $'\n' sh -c 'for arg do echo "Backing up "$arg""; BACKED_UP_DIR="$(echo "$arg" | rev | cut --delimiter="/" --fields=1 | rev)"; mkdir "${HOME}/backup-moto_edge_30_pro/Phone-complete/${BACKED_UP_DIR}"; adb pull "$arg"/. "${HOME}/backup-moto_edge_30_pro/Phone-complete/${BACKED_UP_DIR}"; echo ""; done' _ && date

PASSWORD="${1}"

echo "Compress apps directory"
echo ""
date && time 7z a -t7z -mx=9 -ms=on -mf=on -mhc=on -mhe=on -m0=lzma2 -mfb=273 -md=64m -v4g "-p${PASSWORD}" "${HOME}/backup-moto_edge_30_pro/apps.7z" "${HOME}/backup-moto_edge_30_pro/apps/" && date

NUMBER_OF_ARCHIVES=$(find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -name "apps.7z.*" | wc --lines)
if [ ${NUMBER_OF_ARCHIVES} -eq 1 ]
then
  mv "${HOME}/backup-moto_edge_30_pro/apps.7z.001" "${HOME}/backup-moto_edge_30_pro/apps.7z"
fi

echo "Generate checksum(s) for apps archive(s)"
echo ""
${HOME}/git/kyberdrb/Linux_utils_and_gists/generate_checksums_for_split_archive.sh "${HOME}/backup-moto_edge_30_pro/apps.7z"

echo "Verify checksum(s) for apps archive(s)"
echo ""
sha256sum --check "${HOME}/backup-moto_edge_30_pro/apps.sha256sums"

echo ""
echo '--------------------------------------'
echo ""

echo "Compress files and directories"
echo ""
date && time 7z a -t7z -mx=9 -ms=on -mf=on -mhc=on -mhe=on -m0=lzma2 -mfb=273 -md=64m -v4g "-p${PASSWORD}" "${HOME}/backup-moto_edge_30_pro/Phone-complete.7z" "${HOME}/backup-moto_edge_30_pro/Phone-complete/" && date

echo "Generate checksum(s) for files and directories archive(s)"
"${HOME}/git/kyberdrb/Linux_utils_and_gists/generate_checksums_for_split_archive.sh" "${HOME}/backup-moto_edge_30_pro/Phone-complete.7z.001"

echo "Verify checksum(s) for files and directories archive(s)"
echo ""
sha256sum --check "${HOME}/backup-moto_edge_30_pro/Phone-complete.7z.sha256sums"

echo "Check archives password and content"
echo ""
7z l "$(find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -type f -name "Phone-complete.7z*" | sort | head --lines=1)"
7z l "$(find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -type f -name "apps.7z*" | head --lines=1)"

