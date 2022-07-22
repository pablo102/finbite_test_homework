#!/bin/bash
currentconnections=$(netstat -n | grep *:80 | grep ESTABLISHED | wc -l)
N=2
if [ $currentconnections -ge $N ]
then
service nginx restart
fi

service nginx status | grep 'active (running)' > /dev/null 2>&1

if [ $? != 0 ]
then
        sudo service nginx restart > /dev/null
fi