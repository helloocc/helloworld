#!/bin/bash
set -xe

mkdir ~/my_env
cd ~/my_env

#### vim
yum install python-devel python3-devel ruby-devel lua-devel libX11-devel gtk-devel gtk2-devel gtk3-devel ncurses-devel
git clone https://github.com/vim/vim.git
cd vim/
./configure --with-features=huge --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config/ --prefix=/usr
make
make install
cd -

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

git clone https://github.com/tmux/tmux.git
cd tmux
sh autogen.sh
./configure && make
cd -

git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

yum install zsh
#via curl
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#via wget
#sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

