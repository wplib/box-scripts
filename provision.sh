#!/usr/bin/env bash
#
# WPLib Box Provision Script
#

if [[ -d /vagrant/scripts && "$1" != "--force" ]]; then

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

    if [[ ! -d /vagrant/scripts && -d /tmp/box-scripts ]]; then
        #
        #  If this is the initial provisioning then the scripts
        #  will still be in /tmp/box-scripts. Move them over.
        #
        mkdir -p /box
        mkdir -p /box/scripts
        mv /tmp/box-scripts /box/scripts
    fi

    #
    #  Install Box CLI
    #
    echo "Installing the \"In-the-Box\" CLI"
    sudo rm -f /usr/local/bin/box
    sudo chmod +x /box/scripts/guest/cli/box
    sudo ln -s /box/scripts/guest/cli/box /usr/local/bin/box

    #
    #  Enable Tab Completion
    #˚
    echo "Enabling Tab Completion for 'box' command..."
    box enable-tab-completion --quiet

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

    echo "Congratulations! WPLib Box is now installed."

fi
