#!/bin/bash
set -e

OS=`lsb_release -si`
if [ x"$OS" = xUbuntu ];then
    INSTALL_CMD='sudo apt install -y'
elif [ x"$OS" = xCentOS ];then
    INSTALL_CMD='sudo yum install -y'
else
    exit 1
fi


pre_install(){
    $INSTALL_CMD automake wget git zsh
    if [ x"$OS" = xUbuntu ];then
        echo 'ubuntu pre_install'
        $INSTALL_CMD vim-gtk libevent-dev libncurses5-dev
    else
        echo 'yum install'
        $INSTALL_CMD libevent-devel libXt-devel gtk2-devel python-devel python3-devel ruby-devel lua-devel libX11-devel gtk-devel gtk2-devel gtk3-devel ncurses-devel
    fi
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"
}

tmux(){
    if [ x"$OS" = xCentOS ];then
        rpm -qa|grep tmux|xargs rpm -e || true
    fi

    cd $HOME && git clone https://github.com/tmux/tmux.git
    cd tmux
    sh autogen.sh
    ./configure && make
    make install

    cd $HOME && git clone https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
    wget https://raw.githubusercontent.com/helloocc/my-env/master/.tmux.conf -O $HOME/.tmux.conf
    git clone https://github.com/tmux-plugins/tmux-continuum.git $HOME/.tmux
}

zsh_conf(){
    wget https://raw.githubusercontent.com/helloocc/my-env/master/zxx.zsh-theme -P $HOME/.oh-my-zsh/themes
    wget https://raw.githubusercontent.com/helloocc/my-env/master/.zshrc -O $HOME/.zshrc
}

vim(){
    cd $HOME && git clone https://github.com/vim/vim.git
    cd vim
   	./configure \
       --with-features=huge \
       --enable-gui=auto \
       --enable-multibyte \
       --enable-pythoninterp=dynamic \
       --enable-python3interp \
       --enable-cscope \
       --enable-fontset \
       --enable-largefile \
       --enable-fail-if-missing\
       --with-compiledby="helloc" \
       --with-python3-config-dir=/usr/lib/python3.7/config \
       --prefix=/usr/local
	make && sudo make install && echo '[vim compile success!!!]'
}

vim_plugins(){
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
    vim_color_dir='$HOME/.vim/colors'
    if [ ! -d "${vim_color_dir}" ];then
        mkdir -p $vim_color_dir
    fi
    cd $HOME && git clone https://github.com/morhetz/gruvbox.git
    cp ./gruvbox/colors/gruvbox.vim $HOME/.vim/colors/
    wget https://raw.githubusercontent.com/helloocc/my-env/master/.vimrc -O $HOME/.vimrc
}

others(){
    sudo pip3 install tldr thefuck

    cd $HOME && git clone https://github.com/clvv/fasd.git
    cd fasd
    sudo make install

    git clone --depth 1 https://github.com/junegunn/fzf.git $HOME/.fzf
    $HOME/.fzf/install
}

show_usage(){
    cat <<EOF
sh install.sh -s STAGE [OPTION]

OPTIONS:
    -h, --help                  show this message
    -v, --verbose               show info for debug
    -s, --stage <stage_num>     stage number list: [1,2,3]. each stage will exit after execute

EOF
}

if [ $# -eq 0 ]; then
    show_usage
    exit 1
fi

while true; do
    case "$1" in
        -h|--help)
            show_usage
            exit 0
            ;;
        -d|--debug)
            DEBUG=1
            shift
            ;;
        -v|--verbose)
            VERBOSE=1
            set -x
            shift
            ;;
        -s|--stage)
            STAGE="$2"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        *)
            break
            ;;
    esac
done

if [ $STAGE -eq 1 ]; then
    pre_install
elif [ $STAGE -eq 2 ]; then
    zsh_conf
    tmux
    others
elif [ $STAGE -eq 3 ]; then
    vim
    vim_plugins
fi
