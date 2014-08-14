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

chsh -s `which zsh`

symlink .emacs
symlink .zshenv
symlink .zshrc
symlink .zshrc.mine
symlink .gitignore