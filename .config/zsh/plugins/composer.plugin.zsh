# ------------------------------------------------------------------------------
#          FILE:  composer.plugin.zsh
#   DESCRIPTION:  oh-my-zsh composer plugin file.
#        AUTHOR:  Daniel Gomes (me@danielcsgomes.com)
#       VERSION:  1.0.0
# ------------------------------------------------------------------------------

# Composer basic command completion
_composer_get_command_list () {
    $_comp_command1 --no-ansi 2>/dev/null | sed "1,/Available commands/d" | awk '/^[ \t]*[a-z]+/ { print $1 }'
}

_composer_get_required_list () {
    $_comp_command1 show -s --no-ansi 2>/dev/null | sed '1,/requires/d' | awk 'NF > 0 && !/^requires \(dev\)/{ print $1 }'
}

_composer () {
    local curcontext="$curcontext" state line
    typeset -A opt_args
    _arguments \
        '*:: :->subcmds'

    if (( CURRENT == 1 )) || ( ((CURRENT == 2)) && [ "$words[1]" = "global" ] ) ; then
        compadd $(_composer_get_command_list)
    else
        compadd $(_composer_get_required_list)
    fi
}

compdef _composer composer
compdef _composer composer.phar

# Add Composer's global binaries to PATH, using Composer if available.
if (( $+commands[composer] )); then
    autoload -Uz _store_cache _retrieve_cache _cache_invalid

    _retrieve_cache composer

    if [[ -z $__composer_bin_dir ]]; then
        __composer_bin_dir=$(composer global config bin-dir --absolute 2>/dev/null)
        _store_cache composer __composer_bin_dir
    fi

    # Add Composer's global binaries to PATH
    export PATH="$PATH:$__composer_bin_dir"

    unset __composer_bin_dir
else
  [ -d $HOME/.composer/vendor/bin ] && export PATH=$PATH:$HOME/.composer/vendor/bin
  [ -d $HOME/.config/composer/vendor/bin ] && export PATH=$PATH:$HOME/.config/composer/vendor/bin
fi
