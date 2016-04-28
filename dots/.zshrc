# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="avit"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting fzf)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export EDITOR='nvim'

alias tmator='tmuxinator'
alias vim='nvim'
alias el='/Applications/Electron.app/Contents/MacOS/Electron'
alias clock='tty-clock -c -t'

function d(){
  eval "$(docker-machine env default)"
  docker "$@"
}

function dm() {
  eval "$(docker-machine env default)"
  docker-machine "$@"
}

function dc(){
  eval "$(docker-machine env default)"
  docker-compose "$@"
}

function dcbash(){
  eval "$(docker-machine env default)"

  if [[ $1 =~ '^[0-9]+$' ]]; then
    CONTAINER=$(docker ps | grep $1)
  else
    CONTAINER=$(docker-compose ps | grep foreman)
  fi

  if [[ $CONTAINER ]]; then
    docker exec -it $(echo $CONTAINER | perl -lne 'print $& if /^[^\s]+/') bash
  else
    echo "Container not found"
  fi
}

function tunnlr() {
  if [[ $1 ]]; then PORT=$1 else PORT=3001 fi
  echo "codyss-t.tunnlr.com"
  ssh  -nNt -g -R :12821:192.168.99.100:$PORT tunnlr3599@ssh1.tunnlr.com
}

function des_tunnlr() {
  if [[ $1 ]]; then PORT=$1 else PORT=3002 fi
  echo "codyssdesigner-t.tunnlr.com"
  ssh  -nNt -g -R :13218:0.0.0.0:$PORT tunnlr4123@ssh1.tunnlr.com
}

function lscolors(){
  for i in {0..255} ; do
    printf "\x1b[38;5;${i}mcolour${i}\n"
  done
}


# ===============================================================================================
# Source Common Profile
# ===============================================================================================

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

function work(){
  tmator work || tmux attach -t work
}


# ===============================================================================================
# FZF
# ===============================================================================================

# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/codycallahan/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/codycallahan/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */Users/codycallahan/.fzf/man* && -d "/Users/codycallahan/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/Users/codycallahan/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/codycallahan/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/codycallahan/.fzf/shell/key-bindings.zsh"

# fzf Completion
export FZF_COMPLETION_TRIGGER='**'
bindkey '^T' fzf-completion
bindkey '^I' $fzf_default_completion

