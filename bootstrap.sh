#!/usr/bin/env bash
#
# WPLib Box Provisioning Bootstrap Script
#

if [ -d /vagrant/scripts ]; then

    #
    # Move the scripts folder from where is was cloned by
    # WPLib Box's Vagrantfile to where they need to be.
    #

    source /vagrant/scripts/guest/cli/includes/functions
    backupdir=$(next_backup_file "/vagrant/scripts.save")
    mv /vagrant/scripts "${backupdir}"
    mv /tmp/wplib-box-scripts /vagrant/scripts
    echo "The existing /vagrant/scripts folder was renamed ${backupdir}. You may delete if it you do not need it."

    #
    # Now run the provision script
    #
    bash /vagrant/scripts/provision.sh --force

fi


