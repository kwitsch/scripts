#!/bin/bash

# fixes missing dyndns Update with Not changing WAN IPs
# Parameter 1: WAN interface 
# Parameter 2: Filename without folder an extension 

function echlog {
 echo "DNSFix: $1"
 logger "DNSFix: $1"
} 

if [ $# - eq 2] 
 interface=$1
 file=$(/conf/$2.cache)

 if [ -f $file] 
  cached=$(awk -F'|' '{print $1}' $file) 
  fetched=$(curl -s 'https://api.ipify.org/' --interface $interface) 

  if [ "$cached" = "$fetched" ]; then
   echlog "ok" 
  else
   echlog "fixing" 
   /etc/rc.dyndns.update;
  fi
 else
   echlog "dns file is missing" 
   /etc/rc.dyndns.update;
 fi
else
 echlog "wrong arguments" 
fi
