## Dotfiles repository

### What will be installed and configured
- i3 window manager
- Midnight Commander file manager
- Ripgrep
- Neovim
  - VimPlug
  - fzf plugin
  - some vim shortcuts for fzf and ripgrep

### How-to configure and use this dotfiles
There are two ways of doing it.
If you want to learn a simple and elegant way to configure your own dotfiles, you should follow the Atlassian 'how-to' and build your own configs.
Or you should use my summary and shell script installer.

#### Atlassian how-to: 
https://www.atlassian.com/br/git/tutorials/dotfiles

#### My short summary and direct form to take this configs done

1. Be sure to have git installed on your local machine.
1. Create the $HOME/.dotfiles directory.
1. In yout $HOME folder run `git clone --bare <this-repo-url> $HOME/.dotfiles`
1. Define the 'cfg' alias in current scope with `alias cfg='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
1. Run `cfg checkout -f` at $HOME folder to overwrite existing .dotfiles, or without -f option to follow the Atlassian instructions.
1. Run `./install.sh`script.
1. The git commands **(only)** for **this** repository are now called using the alias `cfg`and not `git` anymore.
1. You are ready to work with your tools and change your config files.

