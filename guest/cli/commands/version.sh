#!/usr/bin/env bash

version="<0.11.0"

if [ -f "/box/version" ]; then
    read fileVersion < /box/version

    if [ $fileVersion == "0.11.0" ]; then
        version="~0.11.0 - 0.13.0"
    else
        version=${fileVersion}
    fi
fi

echo ${version}

return 0