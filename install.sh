#!/bin/bash

packcmd=''

function checkPackMan(){
  if [ "`whereis pkg`" != "pkg:" ]; then
    packcmd="pkg install"
    echo "-> Using 'pkg' package manager"
  elif [ "`whereis pacman`" != "pacman:" ]; then
    packcmd="pacman -S"
    echo "-> Using 'pacman' package manager"
  else
    packcmd="sudo apt install"
    echo "-> Using 'apt' package manager"
  fi
}

function checkInstall(){
  if [ "`whereis $1`" == "$1:" ]; then
    echo "-> Installing $1"
    echo "$packcmd install $*"
  else
    echo "-> ${1^} already installed"
  fi
}

# check package manager
checkPackMan
# install git
checkInstall "git"
# install mc
checkInstall "mc"
# install neovim
checkInstall "neovim"
# install vimplug
 #sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
 #       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
# install i3
checkInstall "i3" "i3lock" "i3status" "i3blocks"
# install utilities
checkInstall "numlockx" "feh" "flameshot" "ffmpeg" "slop"

# install vim plugins
echo "vim -c 'PlugInstall'"
