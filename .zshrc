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
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim' 'lazykube')

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
	git
	git-prompt
	zsh-kubectl-prompt
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

# User configuration

# You may need to manually set your language environment
export LANG=en_GB.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# Enable colors and change prompt:

alias gitrsubs="git submodule foreach 'git fetch origin --tags; git checkout master; git pull' && git pull && git submodule update --init --recursive"
alias vim="nvim"
alias ls="eza --icons=always"
alias cd="z"
alias gotest="go test -race ./..."

autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}"
PS1="$PS1 $(git_super_status)"
PS1="$PS1$%b "

RPROMPT='%{$fg[blue]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

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

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

export ANDROID_HOME="$HOME/Android/Sdk"

# Local language bins
export PATH=~/.netrc:$PATH
export PATH=~/go/bin:$PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit

source <(kubectl completion zsh)


# Carapace setup
export LS_COLORS="$(vivid generate tokyonight-moon)"
export CARAPACE_BRIDGES='zsh,bash' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

_evalcache starship init zsh
_evalcache thefuck --alias
_evalcache zoxide init zsh
_evalcache pyenv init - zsh
_evalcache register-python-argcomplete --no-defaults exegol
_evalcache atuin init zsh

if [[ `uname` == "Linux" ]]; then
    alias sdn="shutdown -h now"
    alias sdr="shutdown -r now"
fi

if [[ `uname` == "Darwin" ]]; then
    alias ls="gls --color"
    export PATH=/opt/homebrew/bin:$PATH
    complete -C '/opt/homebrew/bin/aws_completer' aws
    complete -C '/opt/homebrew/bin/aws_completer' awslocal
fi

if [[ "$ZPROF" = true ]]; then
  zprof
fi
