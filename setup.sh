#!/bin/zsh

set -e

NS=~/.nostromo

if [ ! -d ~/.zprezto ]
then
  git clone --recursive https://github.com/htuch/prezto.git -b htuch-nostromo ~/.zprezto
  git clone https://github.com/tarruda/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
  git clone https://github.com/VundleVim/Vundle.vim.git ${NS}/.vim/bundle/Vundle.vim
  git clone https://github.com/Tarrasch/zsh-bd.git ~/.zsh/zsh-bd
  git clone https://github.com/htuch/powerline.git -b htuch-nostromo ~/.powerline
  pip install --user --editable ~/.powerline

  setopt EXTENDED_GLOB
  for rcfile in ~/.zprezto/runcoms/^README.md(.N); do
          echo $rcfile
          ln -snf "$rcfile" ~/.${rcfile:t}
  done
fi

DOTLINKS=".dir_colors .gitignore .inputrc .tmux.conf .tmux.nested .tmux.shared .vim .vimrc"

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

vim +PluginInstall +qall

chsh -s /bin/zsh
