#/usr/bin/env bash

source ../.env

if [ ! -d ./creds ];
then 
    mkdir ./creds
fi

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

get_pass
echo $data | jq > ./creds/password.json

sudo terraform output -raw private_key > ./creds/private_key.pem

echo "==============="
echo "ssh -i ./creds/private_key.pem ubuntu@$UBUNTU_ADDRESS"
echo "==============="