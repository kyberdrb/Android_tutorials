#!/bin/sh

set -x

PASSWORD="${1}"

IP_ADDRESS="${2}"
#IP_ADDRESS="192.168.60.252"

PORT_CONNECT="${3}"
#PORT_CONNECT="40677"

PORT_PAIR="${4}"
#PORT_PAIR="43061"

adb kill-server
adb start-server

# TODO establish wireless ADB connection between phone and PC
#adb pair ${IP_ADDRESS}:${PORT_PAIR}

adb connect ${IP_ADDRESS}:${PORT_CONNECT}

echo "Checking wireless ADB connection..."
read

ANDROID_DEVICE="$(adb devices | tail --lines=+2 | head --lines=1)"
if [ -z ${ANDROID_DEVICE} ]
then
    echo "No Android device found. Please, connect an Android device via USB cable or via wireless/Wi-Fi ADB connection"
    exit 1
fi

echo "ADB connection established."

echo "Backing up apps"
echo ""
gio trash "${HOME}/backup-moto_edge_30_pro/apps/"
mkdir --parents "${HOME}/backup-moto_edge_30_pro/apps/"
adb shell pm list packages -f -3 | rev | cut --delimiter='=' --fields=1 | rev > "${HOME}/backup-moto_edge_30_pro/apps/apps-list.txt"

echo "waiting for a human to verify output..."
#read

echo "Backing up files from root dir"
echo ""
gio trash "${HOME}/backup-moto_edge_30_pro/files/"
mkdir --parents "${HOME}/backup-moto_edge_30_pro/files/"
 
echo "Downloading files only from the phone's root dir via ADB..."
#read

date && time adb shell "find /sdcard/ -maxdepth 1 -type f" | grep --invert-match "^Android$" | sort | xargs -d $'\n' sh -c 'for arg do echo "Backing up "$arg""; adb pull "$arg" "${HOME}/backup-moto_edge_30_pro/files/"; adb pull "$arg" "${HOME}/backup-moto_edge_30_pro/Phone-complete/";  echo ""; done' _ && date

echo "Done downloading files only from the phone's root dir via ADB..."
#read

#gio trash "${HOME}/backup-moto_edge_30_pro/Phone-complete/"
mkdir --parents "${HOME}/backup-moto_edge_30_pro/Phone-complete/"

cat << EOF
Download files via FTP server and (phone's hotspot - for highest speed) Wi-Fi network and via Filezilla on the PC side (for convenience)

OR

Generate file list via remote ADB connection and download them one-by-one or parallely via xargs and curl
EOF

date
adb shell "find /sdcard/ -maxdepth 1 -mindepth 1 -type d" | grep --invert-match "Android$" | sort | \
xargs -d $'\n' sh -c '
    for arg; do
        echo "Backing up $arg"
        BACKED_UP_DIR="$(basename "$arg")"
        mkdir -p "${HOME}/backup-moto_edge_30_pro/Phone-complete/${BACKED_UP_DIR}"
        adb pull "$arg"/. "${HOME}/backup-moto_edge_30_pro/Phone-complete/${BACKED_UP_DIR}"
        echo ""
    done
' _
date

echo "Waiting for all chosen phone's files to be backed up. Press any key to proceed or Ctrl+C to abort."

read

echo "Delete previous archive(s) and checksum file"
find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -name "apps.*" -exec gio trash {} \;

echo "Compress apps directory"
read

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

echo "Verify checksum for apps archive"
echo ""
sha256sum --check "${HOME}/backup-moto_edge_30_pro/apps.sha256sums"

echo ""
echo '--------------------------------------'
echo ""

echo "Delete previous archive(s) and checksum file"
find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -name "files.*" -exec gio trash {} \;

echo "Compress files backed up from the Phone's root dir"
echo ""

date && time 7z a -t7z -mx=9 -ms=on -mf=on -mhc=on -mhe=on -m0=lzma2 -mfb=273 -md=64m -v4g "-p${PASSWORD}" "${HOME}/backup-moto_edge_30_pro/files.7z" "${HOME}/backup-moto_edge_30_pro/files/" && date

NUMBER_OF_ARCHIVES=$(find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -name "files.7z.*" | wc --lines)
if [ ${NUMBER_OF_ARCHIVES} -eq 1 ]
then
  mv "${HOME}/backup-moto_edge_30_pro/files.7z.001" "${HOME}/backup-moto_edge_30_pro/files.7z"
fi

echo "Generate checksum(s) for apps archive(s)"
echo ""
${HOME}/git/kyberdrb/Linux_utils_and_gists/generate_checksums_for_split_archive.sh "${HOME}/backup-moto_edge_30_pro/files.7z"

echo "Verify checksum for apps archive"
echo ""
sha256sum --check "${HOME}/backup-moto_edge_30_pro/files.sha256sums"

echo ""
echo '--------------------------------------'
echo ""

echo "Delete previous archive(s) and checksum file"
find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -name "Phone-complete.*" -exec gio trash {} \;

echo "Compress files and directories from complete phone backup"
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
7z l "$(find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -type f -name "files.7z*" | head --lines=1)"
7z l "$(find "${HOME}/backup-moto_edge_30_pro/" -maxdepth 1 -type f -name "apps.7z*" | head --lines=1)"

set +x

