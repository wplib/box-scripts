#!/usr/bin/env bash
#
# WPLib Box Provision Script
#

if [[ -f "/opt/box/box" && "$1" != "--force" ]]; then

    echo -e "\t"
    echo "NOTICE! ============>"
    echo -e "\t"
    echo "The /opt/box/box command has already been installed."
    echo "To reprovision please run:"
    echo -e "\t"
    echo -e "\tvagrant reload --provision"
    echo -e "\t"
    echo "Or, if that fails, just try running:"
    echo -e "\t"
    echo -e "\tvagrant up"
    echo -e "\t"

else

    if [[ ! -f /opt/box/box && -f /tmp/box-scripts ]]; then
        #
        #  If this is the initial provisioning then the scripts
        #  will still be in /tmp/box-scripts. Move them over.
        #
        sudo mkdir -p /opt/box
        sudo mv /tmp/box-scripts/* /opt/box
        git pull
    fi

    #
    #  Install Box CLI
    #
    echo "Installing the \"In-the-Box\" CLI"
    sudo rm -f /usr/local/bin/box
    sudo chmod +x /opt/box/box
    sudo ln -s /opt/box/box /usr/local/bin/box

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
