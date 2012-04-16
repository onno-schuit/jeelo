#!/bin/bash

usageQuit()
{
  echo "Usage: $0 -d database -w webroot"
  exit 1
}

DATABASE=
WEBROOT=
while getopts d:w: OPTION
do
     case $OPTION in
         d)
             DATABASE=$OPTARG
             ;;
         w)
             WEBROOT=$OPTARG
             ;;
         ?)
             usageQuit
             exit
             ;;
     esac
done
 
if [[ -z $DATABASE ]] || [[ -z $WEBROOT ]]
then
    usageQuit
    exit 1
fi
echo "DATABASE: ${DATABASE} / WEBROOT: ${WEBROOT}"
