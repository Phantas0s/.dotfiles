bm() {
	local opts add delete list config update edit path
	opts="$(getopt --options hea:dlc:u: --longoptions help,edit,add:,delete,list,config:,update: --name "${FUNCNAME[0]}" -- "${@}")"
	config="${XDG_CONFIG_HOME:-${HOME}/.config}/bookmarks/bm.rc"

	eval set -- "${opts}"
	while true; do
		case "${1}" in
			-h | --help )
				cat << EOF
CD, but with bookmarks/aliases

USAGE: ${FUNCNAME[0]} [OPTIONS] BOOKMARK

OPTIONS:
	-h, --help		Show this help message
	-e, --edit		Edit configuration file (\$EDITOR or vi)
	-a, --add PATH		Add 'BOOKMARM = PATH' to config
	-u, --update PATH	Update BOOKMARK's path to PATH
	-d, --delete		Remove BOOKMARK from config
	-l, --list		List existing bookmarks, filter by BOOKMARK if specified
	-c, --config PATH	Use PATH as config, rather than default (~/.config/cd_bookmarks/config)

CONFIG
	If either the specified configuration file, or the default, does not exist,
	it **will** be created at execution.

	The configuration file should be formatted as
		BOOKMARK = PATH
EOF
				return 0
				;;
			-a | --add )		add="1"; path="${2}"; shift;;
			-d | --delete )		delete="1";;
			-l | --list )		list="1";;
			-c | --config )		config="${2}"; shift;;
			-u | --update )		update="1"; path="${2}"; shift;;
			-e | --edit )		edit="1";;
			-- )				shift; break;;
			* )					break;;
		esac
		shift
	done

	[[ "${config%/*}" != "${config}" ]] && mkdir --parents "${config%/*}"
	touch -a "${config}"

	if [ -n "${list}" ]; then
		awk --assign "filter=${*:-.*}" 'match($0, filter)' "${config}"
	elif [ -n "${edit}" ]; then
		"${EDITOR:-$(command -v vi)}" "${config}"
	elif [ -z "${*}" ]; then
		printf '%s\n' "No bookmark specified" >&2
		return 1
	elif [ -n "${add}" ] || [ -n "${update}" ]; then
		path="$(realpath "${path/~/${HOME}}")"
		if grep --quiet "^${*} = " "${config}"; then
			if [ -n "${add}" ]; then
				printf '%s\n' "Bookmark already defined" >&2
				return 1
			fi
			sed -i'' "s/^${*} = .*$/${*} = ${path}" "${config}"
		elif [ -n "${update}" ]; then
			printf '%s\n' "Bookmark undefined" >&2
			return 1
		else
			printf '%s = %s\n' "${*}" "${path}" >> "${config}"
		fi
	elif [ -n "${delete}" ]; then
		if ! grep --quiet "^${*} = " "${config}"; then
			printf '%s\n' "Bookmark undefined" >&2
			return 1
		fi
		sed -i'' "/^${*} = .*$/d" "${config}"
	elif ! grep --quiet "^${*} = " "${config}"; then
		printf '%s\n' "Bookmark is not defined" >&2
		return 1
	elif ! cd "$(grep "^${*} = " "${config}" | cut --fields="3-" --delimiter=" ")"; then
		printf '%s\n' "Failed to navigate to bookmark" >&2
		return 1
	fi

	return 0
}
