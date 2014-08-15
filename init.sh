#!/usr/bin/env bash

function symlink() {
    if [ -L $HOME/$1 ]; then
	return 0
    fi	
    if [ -a $HOME/$1 ]; then
	mv $HOME/$1 $HOME/$1.bak
    fi
    ln -s $HOME/myenv/$1 $HOME/$1
    return 0
}

if [ "$SHELL" != "`which zsh`" ]; then
    chsh -s `which zsh`
fi

symlink .emacs
symlink .emacs.d
symlink .zshenv
symlink .zshrc
# symlink .zshrc.mine
symlink .gitignore
symlink .screenrc
