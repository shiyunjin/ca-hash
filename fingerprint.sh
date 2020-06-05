#!/bin/bash

shell_dir=$(cd "$(dirname "$0")";pwd)
ca_file=$(cat $shell_dir/ca.pem)

rm -f $shell_dir/trust.fb

IFS='#'
ca_array=($ca_file)
 
for item in ${ca_array[@]}
do
    if [ $item ]; then
        echo "#"$item | openssl x509 -pubkey -noout | openssl pkey -pubin -outform der | openssl dgst -sha256 -binary | openssl enc -base64 >> $shell_dir/trust.fb
    fi
done

md5 $shell_dir/trust.fb
