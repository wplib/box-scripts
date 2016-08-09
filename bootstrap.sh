#!/usr/bin/env bash
#
# WPLib Box Provisioning Bootstrap Script
#

if [ ! -d /vagrant/scripts ]; then

    cd /vagrant
    mv /tmp/wplib-box-scripts /vagrant/scripts

fi

#
# Now run the provision script
bash /vagrant/scripts/provision.sh

