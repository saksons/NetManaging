#!/usr/bin/env bash

set -e

rm -rf $path_for_output
mkdir -p $path_for_output

PTS=$(virsh dumpxml --domain $domain | grep /dev/pts | grep console | grep -o "tty='[^']*'" | cut -d"'" -f2)
PASSWORD=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8};echo;)

echo -n $PASSWORD > $path_for_output/mikrotik.pass

expect $path_module/source/setup_net_address.exp $PTS $PASSWORD "${address}/${net_mask}" $interface