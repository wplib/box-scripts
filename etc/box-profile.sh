#!/bin/bash

if [ -x /opt/box/cli/commands/check-mounts ]
then
	/opt/box/cli/commands/check-mounts
fi

if ! shopt -oq posix
then
	if [ -f /usr/share/bash-completion/bash_completion ]
	then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]
	then
		. /etc/bash_completion
	fi
fi

HISTCONTROL=erasedups:ignoreboth
shopt -s histappend

# 0.17.0 - Defines the base project path.
BOX_PROJECTS_ROOT="/projects"
export BOX_PROJECTS_ROOT

# 0.17.0 - Defines the default project to start.
DEFAULT_PROJECT="wplib.box"
export DEFAULT_PROJECT

# Change inital SSH directory to be /project/wplib.box
cd ${BOX_PROJECTS_ROOT}/${DEFAULT_PROJECT}

PATH="/opt/box/bin:/opt/box/sbin:$HOME/bin:${BOX_PROJECTS_ROOT}/${DEFAULT_PROJECT}/.project/bin:$PATH"

