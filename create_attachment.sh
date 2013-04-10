#! /bin/bash

if [ $# -lt 1 ] ;then
    echo "Usage: create_attachment FILE [NAME]"
    echo -e "\tMakes a hardlink to FILE in the Attachments folder (~/ForCorespondence probably)"
    echo -e "\tThe link has the format: BenKrikler_NAME_DATE where DATE=yyyymmdd"
    echo -e "\tIf NAME is ommitted then FILE is used to determine the name string"

    exit 1
fi

echo_and_do(){
    echo $*
    eval "$*"
}

FILE="$1"
if [[ "$FILE" == "\." ]]; then
    echo "Cannot link to just . "
elif [[ "$FILE" =~ "\.*" ]]; then
    FILE=$(echo $FILE|sed -e "s!^\.!$PWD!")
elif [[ "$FILE" =~ "[^/].*" ]]; then
    FILE=$(echo $FILE|sed -e "s!^!$PWD/!")
fi
if [ ! -e "$FILE" ];then
    echo "File \"$FILE\" doesn't exist"
    exit 1
fi

if [ -n "$2" ]; then
    TARGET="$2"
else
    TARGET="$1"
fi
echo $TARGET
TARGET="$(echo $TARGET|sed -e 's!.*/!!' -e 's/\.\w\w\w$//')"
echo $TARGET

DATE="$(date +%Y%m%d)"
ATTACHMENT_FOLDER="~/ForCorrespondence"
EXTENSION="$(echo $FILE| sed -e 's!.*\.!!')"

LINK="BKrikler_${TARGET}_$DATE.$EXTENSION"
echo "Making hard link $LINK"
echo -e "\tto $FILE"
echo -e "\tin $ATTACHMENT_FOLDER"
echo_and_do rm -f "$ATTACHMENT_FOLDER/$LINK"
echo_and_do cp "$FILE" "$ATTACHMENT_FOLDER/$LINK"
