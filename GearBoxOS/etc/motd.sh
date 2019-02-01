#!/bin/sh

if [ -e /opt/gearbox/version ]
then
        VERSION="`cat /opt/gearbox/version`"
else
        VERSION="Unknown"
fi

echo "Welcome to GearBox $VERSION."
echo ""

tput setaf 2
cat <<EOF
EOF
tput sgr0

tput setaf 6
echo "        The Best Local Dev Server for WordPress Developers"
tput sgr0
echo ""

echo -n "Run "
tput setaf 3
echo -n "box help"
tput sgr0
echo " for help, or see the docs at:"
echo ""
tput setaf 3
echo "   - http://gearbox.github.io/"
tput sgr0
echo ""

echo ""
echo "Connect to GearBox:"
tput setaf 3
echo "   - http://$(cat /tmp/udhcpc.ip)/"
echo "   - http://$(cat /tmp/udhcpc.name)/"
tput sgr0
echo ""

exit 0

