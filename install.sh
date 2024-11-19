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
    $packcmd $*
  else
    echo "-> ${1^} already installed"
  fi
}

function checkVimplug(){
  if [ ! -f $HOME/.local/share/nvim/site/autoload/plug.vim ]; then
    echo "-> Installing vimplug"
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  else
    echo "-> Vimplug already installed"
  fi
}

# check package manager
checkPackMan
# install curl
checkInstall "curl"
# install i3 and utilities
i3_install="N"
echo "Install i3 window manager[y/N]? "
read i3_install
if [ "$packcmd" != "pkg install" ] && [[ "$i3_install" =~ [yY] ]]; then
  checkInstall "i3" "i3lock" "i3status" "i3blocks xorg"
  checkInstall "numlockx" "feh" "flameshot" "ffmpeg" "slop"
else
  echo "Don't install i3 window manager and utilities."
fi
# install mc, ripgrep, neovim and tmux
checkInstall "mc ripgrep neovim tmux fzf"
# install vimplug
checkVimplug

# set bash configs and hide untracked files
source $HOME/.bashrc
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# Set config to .gitconfig

# install vim plugins
nvim -c 'PlugInstall' -c ":q" -c ":q";
