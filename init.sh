#!/usr/bin/env bash

function symlink() {
    if [ -L $HOME/$1 ]; then
	return 0
    fi	
    if [ -a $HOME/$1 ]; then
	mv $HOME/$1 $HOME/$1.bak
    fi
    ln -s $HOME/.myenv/$1 $HOME/$1
    return 0
}

function hard_copy() {
    if [ -f $HOME/$1 ]; then
	return 0
    fi
    cp $HOME/.myenv/$1 $HOME/$1
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

git config --global user.email "oono@preferred.jp"
git config --global user.name "Kenta Oono"

# pyenv + anaconda
git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc.local
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc.local
echo 'eval "$(pyenv init -)"' >> $HOME/.zshrc.local
source ~/.zshrc

yes | pyenv install miniconda3-4.3.30
pyenv rehash
pyenv global miniconda3-4.3.30
echo 'export PATH="$PYENV_ROOT/versions/miniconda3-4.3.30/bin/:$PATH"' >> $HOME/.zshrc
source ~/.zshrc
yes | conda update conda

yes | conda create -n anaconda2 python=2.7 anaconda
yes | conda create -n anaconda3 python=3.8 anaconda

# cudnn env
pip install cudnnenv

