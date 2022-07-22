#!/bin/bash
exec 2>/dev/null
echo $(mkdir geo)
out="./geo"
awk -v OFS='\t' '
$7 == "started:" { login[$5]  = $1" "$2 }
$8 ~ "remote_ip=" { ip[$5] = $8 }
$7 == "done" { logout[$5] = $1" "$2 }
END {
  for (user in login)
  print user, ip[user], login[user], logout[user]
}' log_fragment  | while IFS=$'\t' read username remoteip starttime endtime; do
duration=$(dateutils.ddiff -i "%Y.%m.%d %H:%M:%S" -f "%S" "$starttime" "$endtime")
if [ $duration -ge 12 ]
then
ip=$(echo cat $remoteip | sed '/\n/!s/[0-9.]\+/\n&\n/;/^\([0-9]\{1,3\}\.\)\{3\}[0-9]\{1,3\}\n/P;D')
country=$(whois $ip | grep -iE ^country: | awk '{print $2}')
geo=$(echo $country | awk -v OFS='\t' '{print $1}')
checkip=$(awk '{ if ( $0 ~/<$ip>/ ) {print $0} }' $out/*.*)
if [ $ip == $checkip ]
then
continue
else
echo $ip >> $out/$geo
top=$(wc -l $out/* | sort -rh | head -n 6 )
top5=$(echo $top | awk -F"/| " '{print "Top 5 coutries: " $6,$3" sessions, "$10,$7" sessions, "$14,$11" sessions, "$18,$15" sessions, "$22,$19" sessions"}')
echo $top5
fi
fi
done