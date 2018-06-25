#/usr/bin/env bash

################################################################################ 
# Command completion for 'box'
_box()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	local prev=${COMP_WORDS[COMP_CWORD-1]}


	case "${COMP_WORDS[1]}" in
		'cargo')
			# /opt/box/bin/box cargo help
			_box_container
			return 0
			;;

		'container')
			# /opt/box/bin/box container help
			_box_container
			return 0
			;;

		'database')
			COMPREPLY=($(compgen -W "backup import chunk unchunk credentials dbname username password" -- $cur))
			return 0
			;;

		'startup')
			COMPREPLY=($(compgen -W "" -- $cur))
			return 0
			;;

		'restart')
			COMPREPLY=($(compgen -W "" -- $cur))
			return 0
			;;

		'shutdown')
			COMPREPLY=($(compgen -W "" -- $cur))
			return 0
			;;

		'status')
			COMPREPLY=($(compgen -W "" -- $cur))
			return 0
			;;

		'shell')
			COMPREPLY=($(compgen -W "" -- $cur))
			return 0
			;;

		'version')
			COMPREPLY=($(compgen -W "" -- $cur))
			return 0
			;;

		'self-update')
			# compgen -W "$(git --git-dir=/opt/box/.git tag)" -- $cur
			local REPLY="$(git --git-dir=/opt/box/.git for-each-ref --format='%(refname:short)' | cut -d/ -f2- | sort -u | grep '\.')"
			COMPREPLY=($(compgen -W "$REPLY" -- $cur))
			return 0
			;;

		'test')
			_box_test
			return 0
			;;

		'help')
			COMPREPLY=($(compgen -W "" -- $cur))
			return 0
			;;
	esac

	COMPREPLY=($(compgen -W "database cargo container startup restart shutdown status shell version self-update test help" -- $cur))
}
complete -F _box box



################################################################################
# Command completion for 'box container'
_box_container()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	local prev=${COMP_WORDS[COMP_CWORD-1]}

	case "$prev" in
		'stop'|'restart')
			_box_container_running
			return 0
			;;

		'start'|'clean'|'refresh')
			_box_container_stopped
			return 0
			;;

		'ls'|'inspect'|'log'|'uninstall')
			_box_container_all
			return 0
			;;

		'pull'|'install')
			_box_container_dockerhub
			return 0
			;;
	esac

	COMPREPLY=($(compgen -W "install ls start stop rm clean refresh update show shutdown reallyclean inspect log pull" -- $cur))
	return 0
}

_box_container_running()
{
	local cur=${COMP_WORDS[COMP_CWORD]}

	COMPREPLY=($(compgen -W "$(docker container ls -af label=container.project=wplib -f status=running --format='{{.Image}}')" -- $cur))
	return 0
}


_box_container_stopped()
{
	local cur=${COMP_WORDS[COMP_CWORD]}

	COMPREPLY=($(compgen -W "$(docker container ls -af label=container.project=wplib -f status=created -f status=exited --format='{{.Image}}')" -- $cur))
	return 0
}


_box_container_all()
{
	local cur=${COMP_WORDS[COMP_CWORD]}

	COMPREPLY=($(compgen -W "$(docker container ls -af label=container.project=wplib --format='{{.Image}}')" -- $cur))
	return 0
}


_box_container_dockerhub()
{
	local IMAGES
	local IMAGE_NAME
	local VERSIONS
	local IMAGE_VERSION
	local REPLY
	local cur=${COMP_WORDS[COMP_CWORD]}

	IMAGES="$(jq -r '.results|.[]|.name' /opt/box/etc/repositories.json | sort -u)"
	for IMAGE_NAME in $IMAGES
	do
		VERSIONS="$(jq -r '.results|.[]|.name' /opt/box/etc/images/${IMAGE_NAME}.json)"
		for IMAGE_VERSION in $VERSIONS
		do
			if [ "${IMAGE_VERSION}" != "latest" ]
			then
				REPLY="$REPLY wplib/${IMAGE_NAME}:$IMAGE_VERSION"
			fi
		done

	done

	COMPREPLY=($(compgen -W "$REPLY" -- $cur))
	return 0
}





################################################################################
# Command completion for 'box test'
_box_test()
{
	local cur=${COMP_WORDS[COMP_CWORD]}
	local prev=${COMP_WORDS[COMP_CWORD-1]}

	case "$prev" in
		'list'|'ls')
			_box_container_running
			return 0
			;;


		'run')
			_box_test_files
			return 0
			;;
	esac

	COMPREPLY=($(compgen -W "list ls run" -- $cur))
	return 0
}

_box_test_files()
{
	local cur=${COMP_WORDS[COMP_CWORD]}

	COMPREPLY=($(compgen -W "$(find /opt/box/cli/tests -maxdepth 1 -type f -printf '%f\n')" -- $cur))
	return 0
}


