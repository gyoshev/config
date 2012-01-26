autoload -U colors
autoload -U compinit

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "%{$fg_bold[green]%}${ref#refs/heads/}%{$reset_color%}"
  fi
}

# makes color constants available
colors

# enable colored output from ls, etc
export CLICOLOR=1

# expand functions in the prompt
setopt prompt_subst

# prompt
export PS1='%{$fg_bold[blue]%}(~)%{$reset_color%} '
export RPROMPT='${SSH_CONNECTION+"%{$fg_bold[green]%}"}%{$fg_bold[white]%}%~%{$reset_color%} -- $(git_prompt_info)'


if [ -n "$DISPLAY" ]; then
     export BROWSER=google-chrome
fi

_git_remote_branch() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    if (( CURRENT == 2 )); then
      # first arg: operation
      compadd create publish rename delete track
    elif (( CURRENT == 3 )); then
      if [[ $words[2] == "publish" ]]; then
        # second arg: local branch name
        compadd `git branch -l | sed "s/[ \*]//g"`
      else;
        # second arg: remote branch name
        compadd `git branch -r | grep -v HEAD | sed "s/.*\///" | sed "s/ //g"`
      fi
    elif (( CURRENT == 4 )); then
      # third arg: remote name
      compadd `git remote`
    fi
  else;
    _files
  fi
}

compctl -K _git_remote_branch grb

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
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.history
setopt APPEND_HISTORY

export PATH=$HOME/.bin/:/usr/local/bin:$PATH
export NODE_PATH=/usr/lib/node_modules/:$NODE_PATH

# remap home/end keys that don't work?
bindkey "^[[1~" beginning-of-line
bindkey "^[[2~" quoted-insert
bindkey "^[[3~" delete-char
bindkey "^[[4~" end-of-line
bindkey "^[[5~" beginning-of-history
bindkey "^[[6~" end-of-history
