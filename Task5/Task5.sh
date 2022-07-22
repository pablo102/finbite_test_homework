#!/bin/bash
exec 2>/dev/null
echo $(mkdir backup source)
out="./backup"
in="./source"
currentDate=`date +"%Y_%m_%d_%H_%M"`
date=$(echo $currentDate)
file="tempfile.data"
password="Encrypted"
while [ 1==1 ]
do
        dd if=/dev/zero of="$in/$file" bs=1M count=500
if [ -n "$(find "$in/$file" -prune -size +250000000c)" ]; then
    echo $(read $file >> $out/$file-$date.gz | openssl aes-192-cbc -salt -e -k $password | gzip -9 -c &)
    echo $(cat $file << /dev/null)
fi
done