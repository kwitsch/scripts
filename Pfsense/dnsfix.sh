#!/bin/bash

cached=$(awk -F'|' '{print $1}' /conf/dyndns_opt5custom\'\'1.cache)
fetched=$(curl -s 'https://api.ipify.org/' --interface dc1)

if [ "$cached" = "$fetched" ]; then
  echo dnsok
else
  echo dnsfix
  rm -- /conf/dyndns_opt5custom\'\'*.cache;
  /etc/rc.dyndns.update;
fi
