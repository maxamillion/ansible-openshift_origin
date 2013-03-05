#!/bin/bash

oso_rsync_key="/etc/openshift/rsync_id_rsa" 

if ! [[ -f "$oso_rsync_key" ]]; then
  /usr/bin/ssh-keygen -P "" -t rsa -b 2048 -f $oso_rsync_key
  chown root:root $oso_rsync_key
  chmod 644 $oso_rsync_key
fi
