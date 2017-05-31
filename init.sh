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

#pyenv
git clone https://github.com/yyuu/pyenv.git $HOME/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.zshrc.local
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.zshrc.local
echo 'eval "$(pyenv init -)"' >> $HOME/.zshrc.local
source ~/.zshrc

yes | pyenv install anaconda3-4.3.0
pyenv rehash
pyenv global anaconda3-4.3.0
echo 'export PATH="$PYENV_ROOT/versions/anaconda3-2.5.0/bin/:$PATH"' >> $HOME/.zshrc.local
source ~/.zshrc
conda update conda


#rbenv
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv
git clone https://github.com/sstephenson/ruby-build.git $HOME/.rbenv/plugins/ruby-build
exec $SHELL
