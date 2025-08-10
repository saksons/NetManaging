#!/usr/bin/env bash

set -e

if [ ! -d $path_for_output ];
then 
    mkdir -p $path_for_output
fi

PTS=$(virsh dumpxml --domain $domain | grep /dev/pts | grep console | grep -o "tty='[^']*'" | cut -d"'" -f2)
PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8};echo;)

echo -n $PASSWORD > $path_for_output/mikrotik_$domain.pass

if [[ $address == "" ]];
then
    expect $path_module/source/setup.exp $PTS $PASSWORD
else
    expect $path_module/source/setup_net_address.exp $PTS $PASSWORD "${address}/${net_mask}" $interface
fi
