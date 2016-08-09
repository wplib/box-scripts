#!/usr/bin/env bash
#
# WPLib Box Provision Script
#

if [ -d /vagrant/scripts && "$1" != "--force" ]; then

    echo -e "\t"
    echo "NOTICE! ============>"
    echo -e "\t"
    echo "The /scripts/ folder has already been installed. To reprovision"
    echo "WPLib Box please rename or delete the /scripts/ folder then run:"
    echo -e "\t"
    echo -e "\tvagrant reload --provision"
    echo -e "\t"
    echo "Or, if that fails, just try running:"
    echo -e "\t"
    echo -e "\tvagrant up"
    echo -e "\t"

else

    #
    #  Install Box CLI
    #
    echo "Installing the \"In-the-Box\" CLI"
    sudo rm -f /usr/local/bin/box
    sudo chmod +x /vagrant/scripts/guest/cli/box
    sudo ln -s /vagrant/scripts/guest/cli/box /usr/local/bin/box

    #
    #  Disassociate the cloned Git repo and initialize a new repo.
    #
    echo "Disassociating WPLib Box Git repo..."
    box disassociate-git-repo --quiet

    #
    #  Enable Object Caching
    #
    echo "Enabling Redis-based Object Caching..."
    box enable-object-caching --force --quiet

    #
    #  Ignoring Composed Files
    #
    echo "Adding files found in composer.json to .gitignore..."
    box ignore-composed-files --quiet

    #
    # Install the File Watchers
    #
    echo "Installing File Watchers..."
    box install-file-watchers --quiet

    #
    #  Enable File Watchers
    #
    #   Uncomment these after issues #147 and #150 are done.
    #
    #echo "Enabling File Watchers..."
    #box enable-file-watchers --quiet

    echo "Congratulations! WPLib Box is now installed!"

fi