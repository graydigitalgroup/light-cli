# WP-CLI
# A command line interface for WordPress
# https://wp-cli.org/

# Completion for wp
autoload -U +X bashcompinit && bashcompinit
_wp_complete() {
	local cur=${COMP_WORDS[COMP_CWORD]}

	IFS=$'\n';  # want to preserve spaces at the end
	local opts="$(wp cli completions --line="$COMP_LINE" --point="$COMP_POINT")"

	if [[ "$opts" =~ \<file\>\s* ]]
	then
		COMPREPLY=( $(compgen -f -- $cur) )
	elif [[ $opts = "" ]]
	then
		COMPREPLY=( $(compgen -f -- $cur) )
	else
		COMPREPLY=( ${opts[*]} )
	fi
}
complete -o nospace -F _wp_complete wp
