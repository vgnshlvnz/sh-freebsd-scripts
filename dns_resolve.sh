#!/bin/sh

domain="ameldawrites.com"
aname_resolve=$(/usr/bin/host $domain| awk 'NR==2{print $5}')
dns_refused="5(REFUSED)"
resolve_success=$(/usr/bin/touch /root/$domain)

while  [ "$aname_resolve" = $dns_refused  ]
do
        echo 'fail'
        exit 1
         if  [ $? -eq 0 ]
         then
                $resolve_success
         fi
        echo 'script failed'
done
