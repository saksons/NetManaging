#!/usr/bin/env bash

set -e

if [ ! -d $path_for_output ];
then 
    mkdir -p $path_for_output
fi

if [ ! -f $path_for_output/mikrotik.pass ];
then 
    data=$(jq -n '{}')
else
    data=$(jq '.' $path_for_output/mikrotik.pass)
fi

PTS=$(virsh dumpxml --domain $domain | grep /dev/pts | grep console | grep -o "tty='[^']*'" | cut -d"'" -f2)
PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8};echo;)

jq --arg key $domain --arg password $PASSWORD '. + {$key: $password}' <<< "$data" > $path_for_output/mikrotik.pass

if [[ $address == "" ]];
then
    expect $path_module/source/setup.exp $PTS $PASSWORD
else
    expect $path_module/source/setup_net_address.exp $PTS $PASSWORD "${address}/${net_mask}" $interface
fi
