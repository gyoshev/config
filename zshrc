autoload -U colors
autoload -U compinit

# makes color constants available
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

if [ -n "$DISPLAY" ]; then
    export BROWSER=google-chrome
fi

export TERM=gnome-256color

stty -ixon

# completion
compinit

# automatically enter directories without cd
setopt auto_cd

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# vi mode
bindkey -v

# use incremental search
bindkey ^R history-incremental-search-backward

# expand functions in the prompt
setopt prompt_subst

# ignore duplicate history entries
setopt histignoredups

setopt share_history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.history
setopt APPEND_HISTORY

if [ -e "$HOME/.cargo/bin" ]; then
  export PATH=$HOME/.cargo/bin:$PATH
fi

export PATH=$HOME/homebrew/bin:$HOME/.npm/bin:$HOME/.bin:$HOME/.local/bin:/usr/local/sbin:/usr/local/bin:$HOME/homebrew/opt/python@3.11/libexec/bin:$PATH

export NODE_PATH=/usr/lib/node_modules:/usr/local/lib/node_modules:$NODE_PATH

export PATH="/usr/local/opt/php@8.1/bin:$PATH"
export PATH="/usr/local/opt/php@8.1/sbin:$PATH"
export PATH="/usr/local/opt/node@18/bin:$PATH"

eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="/Users/aleksander.gyoshev/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/Users/aleksander.gyoshev/homebrew/opt/openjdk/include"
export PATH="/Users/aleksander.gyoshev/homebrew/opt/ruby/bin:$PATH"
