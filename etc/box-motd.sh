#!/bin/sh

[ -r /etc/lsb-release ] && . /etc/lsb-release

if [ -z "$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
	# Fall back to using the very slow lsb_release utility
	DISTRIB_DESCRIPTION=$(lsb_release -s -d)
fi

if [ -e /opt/box/version ]
then
        VERSION="`cat /opt/box/version`"
else
        VERSION="Unknown"
fi


clear
clear

echo "Welcome to GearBox $VERSION."
echo ""

tput setaf 2
cat <<EOF
    __          _______  _      _ _       ____
    \ \        / /  __ \| |    (_) |     |  _ \\
     \ \  /\  / /| |__) | |     _| |__   | |_) | _____  __
      \ \/  \/ / |  ___/| |    | | '_ \  |  _ < / _ \ \/ /
       \  /\  /  | |    | |____| | |_) | | |_) | (_) >  <
        \/  \/   |_|    |______|_|_.__/  |____/ \___/_/\_\\


EOF
tput sgr0

tput setaf 6
echo "        The Best Local Dev Server for WordPress Developers"
tput sgr0
echo ""
echo ""

echo -n "Run "
tput setaf 3
echo -n "box help"
tput sgr0
echo " for help, or see the docs at:"
echo ""
tput setaf 3
echo "   - http://wplib.github.io/wplib-box/"
tput sgr0
echo ""

exit 0

