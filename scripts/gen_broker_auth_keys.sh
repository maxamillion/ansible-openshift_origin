#!/bin/bash

if ! [[ -d /etc/openshift ]]; then
  mkdir -p /etc/openshift
fi

if ! [[ -f /etc/openshift/server_pub.pem ]]; then
  openssl genrsa -out /etc/openshift/server_priv.pem 2048 
fi

if ! [[ -f /etc/openshift/server_pub.pem ]]; then
  openssl rsa -in /etc/openshift/server_priv.pem -pubout > \
  /etc/openshift/server_pub.pem
fi
