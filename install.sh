#!/bin/bash

cutstring="DO NOT EDIT BELOW THIS LINE"

for name in *; do
  target="$HOME/.$name"
  if [ -e $target ]; then
    if [ ! -L $target ]; then
      cutline=`grep -n "$cutstring" "$target" | sed "s/:.*//"`
      if [[ -n $cutline ]]; then
        let "cutline = $cutline - 1"
        echo "Updating $target"
        head -n $cutline "$target" > update_tmp
        startline=`cat -n "$name" | sort -nr | cut -c8- | grep -n "$cutstring" | sed "s/:.*//"`
        if [[ -n $startline ]]; then
          tail -n $startline "$name" >> update_tmp
        else
          cat "$name" >> update_tmp
        fi
        mv update_tmp "$target"
      else
        echo "WARNING: $target exists but is not a symlink."
      fi
    fi
  else
    if [[ $name != 'install.sh' ]]; then
      echo "Creating $target"
      if [[ -n `grep "$cutstring" "$name"` ]]; then
        cp "$PWD/$name" "$target"
      else
        ln -sf "$PWD/$name" "$target"
      fi
    fi
  fi
done

cp iterm/*.ttf ~/Library/Fonts/

# install vim plugins
vim +BundleInstall +qall

# build vimproc
(cd "$HOME/.vim/bundle/vimproc.vim" && make)
