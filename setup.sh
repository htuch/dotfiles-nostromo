#!/bin/zsh

set -e

NS=~/.nostromo

if [ ! -d ~/.zprezto ]
then
  git clone --recursive https://github.com/htuch/prezto.git -b htuch-nostromo ~/.zprezto
  git clone https://github.com/htuch/zsh-autosuggestions -b htuch-nostromo ~/.zsh/zsh-autosuggestions
  git clone https://github.com/htuch/Vundle.vim.git ${NS}/.vim/bundle/Vundle.vim
  git clone https://github.com/htuch/zsh-bd.git ~/.zsh/zsh-bd
  git clone https://github.com/htuch/powerline.git -b htuch-nostromo ~/.powerline
  pip install --user --editable ~/.powerline
fi


DOTLINKS=".dir_colors .gitignore .inputrc .tmux.conf .vim .vimrc
    .zlogin .zlogout .zpreztorc .zprofile .zshenv .zshrc"

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

~/.nostromo/setup-fzf.sh

vim +PluginInstall +qall

chsh -s /bin/zsh
