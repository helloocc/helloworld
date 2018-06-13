#!/bin/bash
set -xe

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
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

pip install tldr

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
