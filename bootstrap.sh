#!/usr/bin/env bash
#
# WPLib Box Provisioning Bootstrap Script
#

if [ -d /vagrant/scripts ]; then

    #
    # Move the scripts folder from where is was cloned by
    # WPLib Box's Vagrantfile to where they need to be.
    #
    cd /vagrant
    mv /tmp/wplib-box-scripts /vagrant/scripts

    #
    # Now run the provision script
    #
    bash /vagrant/scripts/provision.sh --force

fi


