#!/bin/bash

# Openshift Config Edits
change_made=""

if ! grep 'kernel.sem = 250  32000 32  4096' /etc/sysctl.conf; then
  printf "kernel.sem = 250  32000 32  4096\n" >> /etc/sysctl.conf
  change_made="true"
fi

if ! grep 'net.ipv4.ip_local_port_range = 15000 35530' /etc/sysctl.conf; then
  printf "net.ipv4.ip_local_port_range = 15000 35530" >> /etc/sysctl.conf
  change_made="true"
fi

if ! grep 'net.netfilter.nf_conntrack_max = 1048576' /etc/sysctl.conf; then
  printf "net.netfilter.nf_conntrack_max = 1048576" >> /etc/sysctl.conf
  change_made="true"
fi

if [[ "$change_made" == "true" ]]; then
  sysctl -p /etc/sysctl.conf
fi
