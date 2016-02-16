#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

if [[ $OSTYPE == 'msys' ]]; then
  eval `ssh-agent`
  ssh-add
  return 
fi

# Disable suspend on <C+s>
stty -ixon

term screen-256color
export PATH=/usr/local/sbin:/usr/local/git/bin:$PATH

c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`

parse_git_branch ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        gitver=$(git branch 2>/dev/null| sed -n '/^\*/s/^\* //p')
    else
        return 0
    fi
    echo -e $gitver
}

branch_color ()
{
    if git rev-parse --git-dir >/dev/null 2>&1
    then
        color=""
        if git diff --quiet 2>/dev/null >&2 
        then
            color="${c_green}"
        else
            color=${c_red}
        fi
    else
        return 0
    fi
    echo -ne $color
}

export PATH=$HOME/.npm/bin:$PATH

PS1='[\[$(branch_color)\]$(parse_git_branch)\[${c_sgr0}\]] \u@\[${c_red}\]\w\[${c_sgr0}\]: '

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
