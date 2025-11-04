setopt correct
setopt histignoredups
setopt sharehistory
setopt incappendhistory
setopt interactivecomments

HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=5000

# bindkey -v
export KEYTIMEOUT=1

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

PROMPT='%F{green}%n@%m%f %F{yellow}%~%f '

export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export PATH="$HOME/.local/omnisharp:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"

alias grep='grep --color=auto'
alias ll='lsd -all'
alias l='lsd -l'
alias lg='lazygit'
alias v='nvim'
alias vi='nvim'
alias vim='nvim'
alias c='clear'
alias wiki='wikiman'

bindkey -M vicmd 'jj' vi-cmd-mode
bindkey -M viins 'jj' vi-cmd-mode

AUTOSUGGEST_DIR="${HOME}/.zsh-autosuggestions"
if [ ! -d "$AUTOSUGGEST_DIR" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$AUTOSUGGEST_DIR"
fi
source "$AUTOSUGGEST_DIR/zsh-autosuggestions.zsh"
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

if command -v tmux >/dev/null 2>&1; then
  if [ -z "$TMUX" ] && [ -n "$PS1" ] && [[ "$TERM" != "linux" ]]; then
    tmux attach -t default || tmux new -s default
  fi
fi
PATH=~/cli/sf/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
