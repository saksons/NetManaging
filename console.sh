#/usr/bin/env bash

mkdir creds

get_pass(){
    data=$(jq -n '{}')
    NAMES=$(cat outputs.tf | grep passwords_ | sed "s/output \"//" | sed "s/\" {//")

    for name in $NAMES;
    do 
        # echo "\"$name\": $(sudo terraform output -json $name),";
        passwords=$(sudo terraform output -json $name | jq '. []')
        index=0
        for password in $passwords;
        do
            data=$(jq --arg key $name'_'$index --arg val $(echo $password | tr "\"" " ") '. + {($key): $val}'  <<< $data)
            index=$(($index + 1))
        done
    done
}

output_nftables() {
    interface=$(ip -br a | grep 10.10.10 | awk -F ' ' '{ printf $1 }')
    cat << EOF > creds/nftables.conf
define qemu _bridge_if = "$interface"

table ip nat {
    chain postrouting {
        type nat hook postrouting priority 100; policy accept;
        
        # "masquerade" means the servers to which one connects from the VM can't tell packets are coming from the latter
        ip saddr 10.10.10.0/24 masquerade
    }
}

table inet filter {
    # "input" is the name of the chain
    chain input {
        
        # -------------------------------- qemu
        iifname $qemu_bridge_if accept  comment "accept from virtual VM"
        
        # packets that reach here are bound to be dropped
        counter comment "count dropped packets"
    }

    chain forward {
        type filter hook forward priority 0; policy drop;
        
        # -------------------------------- qemu
        iifname $qemu_bridge_if accept  comment "accept VM interface as input"
        oifname $qemu_bridge_if accept comment "accept VM interface as output"
        
        counter comment "count dropped packets"
    }
}
EOF
}

echo $data | jq > ./creds/password.json

sudo terraform output -raw private_key > ./creds/private_key.pem

echo "==============="
echo "ssh -i ./creds/private_key.pem arch@{ip}"
echo "==============="
echo "sudo nft -f ./creds/nftables.conf"
echo "==============="