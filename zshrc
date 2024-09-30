# Aliases
if [[ -f $HOME/.zsh_aliases ]]
then
    source $HOME/.zsh_aliases
fi

# .profile
if [[ -f $HOME/.profile ]]
then
    source $HOME/.profile
fi

fpath=($HOME/.zsh/completion)
autoload -Uz compinit
autoload -Uz vcs_info
compinit -u

# begin: git
#autoload -Uz compinit && compinit
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
# PROMPT=\$vcs_info_msg_0_'%# '
zstyle ':vcs_info:git:*' formats '%b'
# end: git

bindkey -v
export KEYTIMEOUT=1
export EDITOR='vim --clean'

edit() {
    vim --clean $@
}

## Init
setopt PROMPT_SUBST

## Options
THEME_PROMPT_PREFIX=${THEME_PROMPT_PREFIX:-''}
THEME_VI_INS_MODE_SYMBOL=${THEME_VI_INS_MODE_SYMBOL:-'λ'}
THEME_VI_CMD_MODE_SYMBOL=${THEME_VI_CMD_MODE_SYMBOL:-'ᐅ'}

## Set symbol for the initial mode
THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"

# on keymap change, define the mode and redraw prompt
zle-keymap-select() {
  if [ "${KEYMAP}" = 'vicmd' ]; then
    THEME_VI_MODE_SYMBOL="${THEME_VI_CMD_MODE_SYMBOL}"
  else
    THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
  fi
  zle reset-prompt
}
zle -N zle-keymap-select

# reset to default mode at the end of line input reading
zle-line-finish() {
  THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
}
zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode, you'd be prompted with CMD mode indicator
# while in fact you would be in INS mode.
# Fixed by catching SIGINT (C-c), set mode to INS and repropagate the SIGINT,
# so if anything else depends on it, we will not break it.
TRAPINT() {
  THEME_VI_MODE_SYMBOL="${THEME_VI_INS_MODE_SYMBOL}"
  return $(( 128 + $1 ))
}

PROMPT='$THEME_PROMPT_PREFIX%f%B%F{240}%1~%f%b %(?.%F{green}$THEME_VI_MODE_SYMBOL.%F{red}$THEME_VI_MODE_SYMBOL)%F{reset_color} '

