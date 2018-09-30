#!/bin/bash
set -xe

OS=`lsb_release -si`
if [ x$OS = xUbuntu ];then
    INSTALL_CMD='apt install'
elif [ x$OS = xCentos ];then
    INSTALL_CMD='yum install'
else
    exit 1
fi


pre_install(){
    if [ $INSTALL_CMD = 'apt install' ];then
        echo 'ubuntu pre_install'
        sudo $INSTALL_CMD vim-gtk
    else
        echo 'yum install'
        sudo $INSTALL_CMD libXt-devel gtk2-devel python-devel python3-devel ruby-devel lua-devel libX11-devel gtk-devel gtk2-devel gtk3-devel ncurses-devel
    fi
}

tmux(){
    git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make
    cd -

    git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    wget https://raw.githubusercontent.com/helloocc/my-env/master/.tmux.conf -P ~/

    git clone https://github.com/tmux-plugins/tmux-continuum.git ~/.tmux
}

zsh(){
    sudo $INSTALL_CMD zsh
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
    wget https://raw.githubusercontent.com/helloocc/my-env/master/zxx.zsh-theme -P ~/.oh-my-zsh/themes
    wget https://raw.githubusercontent.com/helloocc/my-env/master/.zshrc -P ~/
}

vim(){
    git clone https://github.com/vim/vim.git ~/vim
    cd vim/
    ./configure --with-features=huge --with-x --enable-gui --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config/ --prefix=/usr
    sudo make && make install
    cd -
}

vim_plugins(){
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    vim_color_dir='~/.vim/colors'
    if [ ! -d "${vim_color_dir}" ];then
        mkdir -p $vim_color_dir
    fi
    git clone https://github.com/morhetz/gruvbox.git ~/.vim/colors/
    wget https://raw.githubusercontent.com/helloocc/my-env/master/.vimrc -P ~/
}

others(){
    sudo pip install tldr

    git clone https://github.com/clvv/fasd.git
    cd fasd/
    sudo make install

    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
}

pre_install
tmux
zsh
vim
vim_plugins
others
