# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ls -lt'
alias ..="cd .."

# Commands
alias open=xdg-open
alias searchpr="ps -ef | grep"
alias his="history | grep"
alias stat="git status"
alias add="git add"
alias gco="git commit -m"
alias commit="git commit -m"
alias gps="git push"
alias push="git push"
alias gpl="git pull"
alias pull="git pull"
alias gdi="git diff"
alias dif="git diff"
alias gch="git checkout"
alias chk="git checkout"
alias gbr="git branch"
alias bra="git branch"
alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias mci="mvn clean install"
alias msr="mvn spring-boot:run"
alias mte="mvn test"
alias procs="ps -ef"
alias proc="ps -ef | grep"
alias addcommit="git add . && git commit -m ${1}"
alias i3w="cd $HOME/.config/i3"
alias i3c="nvim $HOME/.config/i3/config_home"
alias updi3="$HOME/.config/i3/scripts/update_config.sh"
alias start="npm run start"
alias tests="npm run test"
alias rmm="shred -n 2 -z -u -v"
alias ali="alias | grep $1"
alias fbash="cat ~/.bashrc | grep"
alias ebash="nvim $HOME/.bashrc"
alias fj="firejail --list"

#alias vboxup='vboxmanage modifymedium disk $1 --resize $2'
alias updbx="source ~/.bashrc"
alias drv="lsblk"
alias tm="tmux"

alias nf="nvim \"\`fzf\`\""

function vboxup() {
    disk=$1
    dsize=$2
    if [[ $disk && $dsize ]]; then
	vboxmanage modifymedium disk "$disk" --resize $dsize
    fi
}

alias pdf="zathura"

## Busca na web
alias st="open https\://www.startpage.com/do/search?q=$1\&segment=startpage.brave"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.


addsource(){
  if [ -f $1 ]; then
      . $1
  fi
}

addsource "~/.bash_aliases"
addsource "$HOME/.bovbash"
addsource "$HOME/.scrbash"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Roda programa python 3
alias p3="python3"

# Abre editor mcedit
alias me="mcedit"

# Copia texto para clipboard
alias ct="echo \"$*\" | xclip -i -selection"

#Exibe atalhos do i3
i3a() { cat $HOME/.config/i3/config_home | sed -e 's/bindsym\ //' | sed -e 's/\$mod/Win/' | sed -e 's/exec/→/' | grep $1 ;}

# Atualiza definições de xterm
alias xr="xrdb ~/.Xresources"

# Proton VPN
# opções: login, c(connect), s(status), d(disconnect)
alias vpn="protonvpn-cli"

function pomo() {
    arg1=$1
    shift
    args="$*"

    min=${arg1:?Example: pomo 15 Take a break}
    sec=$((min * 60))
    msg="${args:?Example: pomo 15 Take a break}"

    echo "notify-send -u critical -t 0 -a pomo 'Finalizando' '${msg:?}'" | at now +${sec}
}

export I3_ENV=home
export I3_FOLDER=$HOME/.config/i3
export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
