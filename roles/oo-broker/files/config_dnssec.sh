#!/bin/bash

# $keyfile will contain a new DNSSEC key for our domain.
keyfile=/var/named/${domain}.key

if [ "x$bind_key" = x ]
then
  # Generate the new key for the domain.
  pushd /var/named
  rm -f /var/named/K${domain}*
  dnssec-keygen -a HMAC-MD5 -b 512 -n USER -r /dev/urandom ${domain}
  bind_key="$(grep Key: K${domain}*.private | cut -d ' ' -f 2)"
  popd
fi

# Ensure we have a key for service named status to communicate with BIND.
rndc-confgen -a -r /dev/urandom
restorecon /etc/rndc.* /etc/named.*
chown root:named /etc/rndc.key
chmod 640 /etc/rndc.key


