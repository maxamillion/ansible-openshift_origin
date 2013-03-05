#!/bin/bash


if ! grep '__default__/broker' /etc/httpd/conf.d/openshift/nodes.txt; then
  cat /etc/httpd/conf.d/openshift/nodes.txt \
    /tmp/nodes.broker_routes.txt > /etc/httpd/conf.d/openshift/nodes.txt.new

  mv /etc/httpd/conf.d/openshift/nodes.txt.new \
    /etc/httpd/conf.d/openshift/nodes.txt

  httxt2dbm -f DB -i /etc/httpd/conf.d/openshift/nodes.txt -o \
    /etc/httpd/conf.d/openshift/nodes.db.new
   
  chown root:apache /etc/httpd/conf.d/openshift/nodes.txt \
    /etc/httpd/conf.d/openshift/nodes.db.new 
    
  chmod 750 /etc/httpd/conf.d/openshift/nodes.txt \
    /etc/httpd/conf.d/openshift/nodes.db.new 
    
  mv -f /etc/httpd/conf.d/openshift/nodes.db.new \
    /etc/httpd/conf.d/openshift/nodes.db
fi
