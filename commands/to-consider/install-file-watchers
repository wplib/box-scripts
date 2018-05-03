#!/usr/bin/env bash

if [ -d "${WPLIB_BOX_WATCHERS_DIR}" ]; then

    echo_if_not_quiet "$*" "=Watchers already installed."

else

    cp -rf "${WPLIB_BOX_FILES_DIR}/watchers/" "${WPLIB_BOX_WATCHERS_DIR}/"

    echo_if_not_quiet "$*" "=Watchers installed."

fi