#!/bin/zsh

symlink() {
    ln -snf ~/.nostromo/bin/$1 ~/.nostromo/bin/fzf
}

version=0.11.0
archi=$(uname -sm)
echo $archi
case "$archi" in
  Darwin\ x86_64) symlink fzf-$version-darwin_${binary_arch:-amd64} ;;
  Darwin\ i*86)   symlink fzf-$version-darwin_${binary_arch:-386}   ;;
  Linux\ x86_64)  symlink fzf-$version-linux_${binary_arch:-amd64}  ;;
  Linux\ i*86)    symlink fzf-$version-linux_${binary_arch:-386}    ;;
  *)              echo "No fzf binary available!"; exit 0  ;;
esac
