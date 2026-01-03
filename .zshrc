# Captures zsh load times in profiler when enabled
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi
 
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$PATH
if [[ ":$FPATH:" != *":$HOME/.zsh/completions:"* ]]; then export FPATH="$HOME/.zsh/completions:$FPATH"; fi

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Load packages and setup autocomplete
export NVM_DIR="$HOME/.nvm"
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true
export NVM_AUTO_USE=true
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim')

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	autoupdate
    zsh-nvm
    zsh-autosuggestions
    zsh-syntax-highlighting
    evalcache
    direnv
    taskwarrior
    timewarrior
)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Set personal aliases
alias vim="nvim"
alias ls="eza --icons=always"
alias cd="z"
alias gotest="go test -race ./..."

gitsubpull() {
    git submodule foreach 'git fetch origin --tags; git checkout master; git pull'
    git pull
    git submodule update --init --recursive
}

# Enable colors 
autoload -U colors && colors

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Bind ctrl-o to open yazi
bindkey -s '^o' 'yazi\n'

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Local language bins
export PATH=~/.netrc:$PATH
export PATH=~/go/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
export ANDROID_HOME="$HOME/Android/Sdk"

# Basic auto/tab complete:
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
_comp_options+=(globdots)		# Include hidden files.
autoload bashcompinit && bashcompinit
source <(kubectl completion zsh)

# Eval inits for various tools
_evalcache starship init zsh
_evalcache thefuck --alias
_evalcache zoxide init zsh
_evalcache pyenv init - zsh
_evalcache register-python-argcomplete --no-defaults exegol
_evalcache atuin init zsh

# Carapace setup
export LS_COLORS="$(vivid generate tokyonight-moon)"
export CARAPACE_BRIDGES='zsh,bash' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

# Restoring taskwarrior completion overridden by carapace
compdef _task task

if [[ `uname` == "Linux" ]]; then
    alias sdn="shutdown -h now"
    alias sdr="shutdown -r now"
fi

if [[ `uname` == "Darwin" ]]; then
    export PATH=/opt/homebrew/bin:$PATH
    complete -C '/opt/homebrew/bin/aws_completer' aws
    complete -C '/opt/homebrew/bin/aws_completer' awslocal
fi

if [[ "$ZPROF" = true ]]; then
  zprof
fi
