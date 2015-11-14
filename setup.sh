#!/bin/zsh

set -e

NS=~/.nostromo

if [ ! -d ~/.zprezto ]
then
  git clone --recursive https://github.com/htuch/prezto.git -b htuch-nostromo ~/.zprezto
  git clone https://github.com/tarruda/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

  setopt EXTENDED_GLOB
  for rcfile in ~/.zprezto/runcoms/^README.md(.N); do
          echo $rcfile
          ln -snf "$rcfile" ~/.${rcfile:t}
  done
fi

DOTLINKS=".dir_colors .gitignore .inputrc"

for d in ${=DOTLINKS}
do
  ln -snf ${NS}/${d} ~/
done

cp -f ${NS}/.gitconfig.local ~/.gitconfig

TOUCHFILES=".zshrc.local .zprofile.local"

for f in ${=TOUCHFILES}
do
  touch ~/${f}
done

chsh -s /bin/zsh
