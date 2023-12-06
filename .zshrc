##################################
### ENV
##################################

export DOTCONFIG="$HOME/.config"
export TERM="xterm-256color"
export PAGER="more"

##################################
### Options
##################################

setopt AUTO_CD              # Go to folder path without using cd.
setopt AUTO_PUSHD           # Push the old directory onto the stack on cd.
setopt PUSHD_IGNORE_DUPS    # Do not store duplicates in the stack.
setopt PUSHD_SILENT         # Do not print the directory stack after pushd or popd.
setopt CORRECT              # Spelling correction
setopt CDABLE_VARS          # Change directory to a path stored in a variable.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt BEEP               # Turn off all beeps

unalias run-help
autoload -U run-help

##################################
### Theme
##################################

PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{cyan}%1~%f%b ❯ '

##################################
### Scripts & Aliases
##################################

source "$DOTCONFIG/zsh/completion.zsh"
source "$DOTCONFIG/zsh/functions.zsh"

for file in "$DOTCONFIG"/zsh/plugins/*.zsh; do
  source "$file"
done

alias composer="php /usr/local/bin/composer"
alias wp="php /usr/local/bin/wp"
alias l="ls -lagh --group-directories-first"
alias ll="ls -lagh --group-directories-first"

PATH=~/.local/bin/:$PATH
