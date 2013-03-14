#!/bin/bash
#
# Check for firewalld configs

d_zone=$(firewall-cmd --get-default-zone)
fwd_cfg=/etc/firewalld/zones/${d_zone}.xml

grep 'name="ssh"' $fwd_cfg && grep 'name="http"' $fwd_cfg && \
grep 'name="https"' $fwd_cfg && grep 'port="8000"' $fwd_cfg && \
grep 'port="8443"' $fwd_cfg 
