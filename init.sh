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

function hard_copy() {
    if [ -f $HOME/$1 ]; then
	return 0
    fi
    cp $HOME/myenv/$1 $HOME/$1
    return 0
}

if [ "$SHELL" != "`which zsh`" ]; then
    chsh -s `which zsh`
fi

symlink .emacs
symlink .emacs.d
symlink .zshenv
symlink .zshrc
symlink .gitignore
symlink .screenrc

hard_copy .zshrc.local

#pyenv
git clone git://github.com/yyuu/pyenv.git $HOME/.pyenv
git clone https://github.com/yyuu/pyenv-pip-rehash.git $HOME/.pyenv/plugins/pyenv-pip-rehash
git clone https://github.com/yyuu/pyenv-virtualenv.git $HOME/.pyenv/plugins/pyenv-virtualenv
exec $SHELL

#rbenv
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
exec $SHELL
