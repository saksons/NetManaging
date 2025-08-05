#!/usr/bin/env bash

MAX_RETRIES=5
RETRY=0

# Create empty json object
# data_for_tf=$(jq -n '{ }')
data_for_file=$(jq -n '{ }')

# Getting params from terraform execution
eval "$(jq -r '@sh "max_vm_count=\(.max_vm_count) path_for_output=\(.path_for_output) domain=\(.domain)"')"


rm -rf $path_for_output
mkdir $path_for_output

# Get net info about mikrotik VM
for ((i=0; i <= $max_vm_count; i++)); do
    iface=$(virsh domiflist --domain $domain'_'$i | grep $domain'_up_link' | awk '{print $1}')
    addr=$(virsh domifaddr --domain $domain'_'$i --interface "$iface" | grep ipv4 | awk '{print $4}' | cut -d'/' -f1)
    
    while [ ! $addr ];
    do
      addr=$(virsh domifaddr --domain $domain'_'$i --interface "$iface" | grep ipv4 | awk '{print $4}' | cut -d'/' -f1)
      sleep 4
      RETRY=$(( $RETRY + 1))
      [[ $MAX_RETRIES == $RETRY ]] && break
    done
  [[ $MAX_RETRIES == $RETRY ]] && break
    json_value=$(jq -c -n --arg iface "$iface" --arg addr "$addr" \
      '{interface: $iface, address: $addr}')
    # data_for_tf=$(jq --arg key $domain'_'$i --arg val "$json_value" '. + {($key): $val}' <<< "$data_for_tf")
    data_for_file=$(jq --arg key $domain'_'$i --arg int $iface --arg addr $addr '. + {($key): {"interface": $int, "address":$addr}}' <<< "$data_for_file")
done

echo "$data_for_file" > $path_for_output/mikrotik_net_info.json

# echo "$data_for_tf"