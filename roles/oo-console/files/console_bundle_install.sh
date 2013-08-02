#!/bin/bash

# Remove Gemfile.lock and bundle install on the local machine,
# then recompile the rails assets
pushd /var/www/openshift/console/
  rm -f Gemfile.lock
  bundle install --local
  rm -fr tmp/cache/*
  rake assets:precompile
  chown -R apache:apache ./*
popd

