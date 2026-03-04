setopt correct
setopt histignoredups
setopt sharehistory
setopt incappendhistory
setopt interactivecomments

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

bindkey -v
export KEYTIMEOUT=1

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

PROMPT='%F{#C9DE95}%n@%m%f %F{#F6D99D}%~%f '

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced

 
alias grep='grep --color=auto'
alias ll='lsd -all'
alias ls='lsd -all'
alias l='lsd -l'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias c='clear'

alias wiki='wikiman'
alias lg='lazygit'
alias blue='bluetui'
alias wifi='impala'

bindkey -M vicmd 'jj' vi-cmd-mode
bindkey -M viins 'jj' vi-cmd-mode



function zle-keymap-select {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne "\e[1 q" 
  else
    echo -ne "\e[5 q"
  fi
}
zle -N zle-keymap-select

function zle-line-init {
  echo -ne "\e[5 q"
}
zle -N zle-line-init


# plugins ==========================================
AUTOSUGGEST_DIR="${HOME}/.config/zsh/.zsh-autosuggestions"
if [ ! -d "$AUTOSUGGEST_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGEST_DIR"
fi
source "$AUTOSUGGEST_DIR/zsh-autosuggestions.zsh"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

SYNTAX_HIGHLIGHTING="${HOME}/.config/zsh/.zsh-syntax-highlighting"
if [ ! -d "$SYNTAX_HIGHLIGHTING" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$SYNTAX_HIGHLIGHTING"
fi
source "$SYNTAX_HIGHLIGHTING/zsh-syntax-highlighting.zsh"


# tmux shit
if command -v tmux >/dev/null 2>&1; then
  if [ -z "$TMUX" ] && [ -n "$PS1" ] && [[ "$TERM" != "linux" ]]; then
    tmux attach -t default || tmux new -s default
  fi
fi

[[ -r "/usr/share/z/z.sh" ]] && source /usr/share/z/z.sh

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$HOME/cli/sf/bin:$HOME/.platformio/penv/bin"

. "$HOME/.local/bin/env"
