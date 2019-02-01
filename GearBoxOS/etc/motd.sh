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

ip="$(ip addr show eth1 | awk '/inet /{gsub(/\/.*/, "", $2); print$2}')"
if [ "${ip}" != "" ]
then
	echo ""
	tput setaf 3
	echo "Connect to your GearBox:"
	echo "   - http://$(cat /tmp/udhcpc.ip)/"
	tput sgr0
	echo ""
fi

exit 0

