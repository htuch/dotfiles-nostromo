#!/bin/zsh

set -e

NS=~/.nostromo

DOTLINKS=".Xresources .xsession .i3"

for d in ${=DOTLINKS}
do
  ln -snf ${NS}/${d} ~/
done
