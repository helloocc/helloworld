#!/bin/bash
set -e

log_info(){
    echo "[INFO]: $1"
}

which_system(){
    if which lsb_release > /dev/null 2>&1;then
        OS=`lsb_release -si`
        if [ x"$OS" = xUbuntu ];then
            log_info "This is Ubuntu system."
            INSTALL_CMD='sudo apt install -y'
        elif [ x"$OS" = xCentOS ];then
            log_info "This is CentOS system."
            INSTALL_CMD='sudo yum install -y'
        else
            exit 1
        fi
    else
        if [[ -n `cat /etc/*-release|grep centos` ]];then
            log_info "This is CentOS system."
            INSTALL_CMD='sudo yum install -y'
        fi
    fi
}

pre_install(){
    $INSTALL_CMD automake wget zsh git tig
    if [ x"$OS" = xUbuntu ];then
        log_info 'ubuntu pre_install'
        $INSTALL_CMD vim-gtk libevent-dev libncurses5-dev exuberant-ctags
    else
        log_info 'yum install'
		yum groupinstall "Development tools" -y
        $INSTALL_CMD epel-release
        $INSTALL_CMD byacc bzip2-devel ctags libevent-devel libffi-devel libuuid-devel libXt-devel libffi-devel libX11-devel \
            ruby-devel gtk2-devel gtk3-devel gdbm-devel ncurses-devel python3-devel readline-devel \
    		openssl-devel sqlite-devel xz-devel zlib-devel
    fi

	cat <<EOF | sudo tee ~/.pip/pip.conf
[global]
index-url=http://mirrors.aliyun.com/pypi/simple/

[install]
trusted-host=
        mirrors.aliyun.com

#ssl_verify: false
EOF

    sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

ctags(){
    log_info 'install u-ctags...'
    local clone_dir=$HOME/ctags
    if [ ! -d $clone_dir ];then
        git clone --depth 1 https://github.com/universal-ctags/ctags.git $clone_dir
    fi
    cd $clone_dir
    ./autogen.sh
    ./configure
    sudo make && sudo make install
    log_info 'ctags install success!'
}

tmux(){
    log_info 'install tmux.'
    if [ x"$OS" = xCentOS ];then
        rpm -qa|grep tmux|xargs rpm -e || true
    fi

    local clone_dir=$HOME/tmux
    if [ ! -d $clone_dir ];then
        git clone --depth 1 https://github.com/tmux/tmux.git $clone_dir
    fi
    cd $clone_dir
    sh autogen.sh
    ./configure
    sudo make && sudo make install && log_info 'tmux install success.'

    log_info 'configure tmux.'
    local clone_dir=$HOME/.tmux
    if [ ! -d $clone_dir ];then
        git clone --depth 1 https://github.com/gpakosz/.tmux.git $clone_dir
    fi
    cd $HOME
    ln -s -f .tmux/.tmux.conf
    cp .tmux/.tmux.conf.local .
}

zsh_conf(){
    log_info 'configure zsh.'
    cp ${WORKSPACE}/zxx.zsh-theme $HOME/.oh-my-zsh/themes
    cp ${WORKSPACE}/.zshrc $HOME
    zsh
}

vim(){
    log_info 'install vim...'
    if [ x"$OS" = xCentOS ];then
        rpm -qa|grep vim-common|xargs rpm -e || true
    fi

    local clone_dir=$HOME/vim
    if [ ! -d $clone_dir ];then
        git clone --depth 1 https://github.com/vim/vim.git $clone_dir
    fi
    cd $clone_dir
    ./configure \
       --with-features=huge \
       --enable-gui=auto \
       --enable-multibyte \
       --enable-python3interp \
       --enable-cscope \
       --enable-fontset \
       --enable-largefile \
       --enable-fail-if-missing\
       --with-compiledby="helloc" \
       --prefix=/usr/local
    sudo make && sudo make install

    if [ -f '/usr/bin/vim' ];then
        mv /usr/bin/vim /usr/bin/vim.bak
    fi
    cp /usr/local/bin/vim /usr/bin/vim
    log_info 'vim install success!'
}

vim_plugins(){
    log_info 'install vim plug.'
    curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    vim_color_dir=$HOME/.vim/colors
    if [ ! -d ${vim_color_dir} ];then
        mkdir -p $vim_color_dir
    fi

    local clone_dir=$HOME/gruvbox
    if [ ! -d $clone_dir ];then
        git clone https://github.com/morhetz/gruvbox.git $clone_dir
    fi
    cp $clone_dir/colors/gruvbox.vim $vim_color_dir
    cp $WORKSPACE/.vimrc $HOME
    cp -r $WORKSPACE/template $HOME/.vim
}

others(){
    log_info 'install tldr.'
    sudo pip3 install tldr thefuck

    log_info 'install fasd.'
    local clone_dir=$HOME/fasd
    if [ ! -d $clone_dir ];then
        git clone --depth 1 https://github.com/clvv/fasd.git $clone_dir
    fi
    cd $clone_dir
    sudo make install
    cd -

    log_info 'install fzf.'
    local clone_dir=$HOME/.fzf
    if [ ! -d $clone_dir ];then
        git clone --depth 1 https://github.com/junegunn/fzf.git $clone_dir
    fi
    $clone_dir/install
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

WORKSPACE=$(readlink -f $(dirname $0))
which_system

if [ $STAGE -eq 1 ]; then
    pre_install
elif [ $STAGE -eq 2 ]; then
    tmux
    ctags
    others
    zsh_conf
elif [ $STAGE -eq 3 ]; then
    vim
    vim_plugins
fi
