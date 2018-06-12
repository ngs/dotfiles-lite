#!/bin/sh

set -eu

DOTFILES=$(cd $(dirname $0) && pwd)

for f in $DOTFILES/rc.d/*; do
  BASENAME=$(basename $f)
  TARGET=$HOME/.$BASENAME
  [ -d $TARGET ] && [ ! -h $TARGET ] && mv $TARGET "${TARGET}.org"
  rm -f $TARGET
  ln -s $f $TARGET
done

curl -sfLo ${DOTFILES}/rc.d/vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall +qall > /dev/null 2>&1
