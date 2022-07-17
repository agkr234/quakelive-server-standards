#!/bin/bash
cd `dirname $0`

items=""

OIFS=$IFS
IFS=$'\n'
echo "these workshop ids will be downloaded"
for item in $(cat ./baseq3/workshop.txt | sed -e 's/^M$//' | sed -e "s/#.*//g"); do
  echo $item
  items="$items +workshop_download_item 282440  $item"
done
IFS=$OIFS

set -x
${HOMEDIR}/steamcmd/steamcmd.sh +login anonymous +force_install_dir "$(pwd)" $items validate +quit