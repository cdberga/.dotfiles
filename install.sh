#!/bin/bash

function checkInstall(){
  if [ "`whereis $1`" == "$1:" ]; then
    echo "-> Installing $1"
    echo "sudo apt install $*"
  else
    echo "${1^} already installed"
  fi
}

# install git
checkInstall "git"
# install mc
checkInstall "mc"
# install neovim
checkInstall "neovim"
# install i3
checkInstall "i3" "i3lock" "i3status" "i3blocks"
# install utilities
checkInstall "numlockx" "feh" "flameshot" "ffmpeg" "slop"

# install vim plugins
echo "vim -c 'PlugInstall'"
