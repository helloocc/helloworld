#!/bin/bash
set -e

log_info(){
    echo "[INFO]: $1"
}

mv_bak(){
    if [ -f $1 || -d $1 || -L $1 ];then
        mv $1 $1.bak
    fi
}

which_system(){
    if [[ -n `cat /etc/*-release|grep NAME=|grep -i CentOS` ]];then
        log_info "This is CentOS system."
        OS='CentOS'
        INSTALL_CMD='sudo yum install -y'
    elif [[ -n `cat /etc/*-release|grep NAME=|grep -i Debian` ]];then
        log_info "This is Debian system."
        OS='Debian'
        INSTALL_CMD='sudo apt install -y'
    fi

    if [ -z $OS ];then
        if which lsb_release > /dev/null 2>&1;then
            OS=`lsb_release -si`
            if [ x"$OS" = xUbuntu ];then
                log_info "This is Ubuntu system."
                INSTALL_CMD='sudo apt install -y'
            else
                log_info "Cant't recognize system."
                exit 1
            fi
        fi
    fi
}

set_proxy(){
	TARGET_IP=$1
	if [ -z $1 ];then
		echo 'no target ip'
		exit 1
	fi
	log_info "Target ip: ${TARGET_IP}"

    if [ ! -d ~/.config ];then
        mkdir ~/.config
    fi

	scp -r root@${TARGET_IP}:/root/clash ~/
	scp -r root@${TARGET_IP}:/root/.config/clash ~/.config
	sudo scp -r root@${TARGET_IP}:/usr/lib/systemd/system/clash.service /usr/lib/systemd/system/
	sudo systemctl daemon-reload
	sudo systemctl restart clash
	sudo systemctl status clash
}

pre_install(){
    $INSTALL_CMD automake wget zsh git tig byacc
    if [[ x"$OS" = xUbuntu ]];then
        $INSTALL_CMD libevent-dev libncurses5-dev exuberant-ctags build-essential autoconf libtool libssl-dev python3-pkgconfig libcurl4-gnutls-dev curl
    elif [[ x"$OS" = xDebian ]];then
        $INSTALL_CMD libevent-dev libncurses5-dev exuberant-ctags python3-dev
    else
		yum groupinstall "Development tools" -y
        $INSTALL_CMD epel-release
        $INSTALL_CMD bzip2-devel ctags libevent-devel libffi-devel libuuid-devel libXt-devel libffi-devel libX11-devel \
            ruby-devel gtk2-devel gtk3-devel gdbm-devel ncurses-devel python3-devel readline-devel \
    		openssl-devel sqlite-devel xz-devel zlib-devel
    fi

    if [ ! -d ~/.pip ];then
        mkdir ~/.pip
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
        sudo mv /usr/bin/vim /usr/bin/vim.bak
    fi
    sudo cp /usr/local/bin/vim /usr/bin/vim
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
    sudo pip3 install tldr thefuck --break-system-packages

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

install_openssl(){
    log_info 'install openssl.'
    cd ${WORKSPACE}
    wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz
	tar -zxvf openssl-1.1.1n.tar.gz
    cd openssl-1.1.1n
    ./config --prefix=/usr/local/openssl && make && make install
    cd -
	mv_bak /usr/bin/openssl
	ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl
    mv_bak /usr/local/openssl/lib/libcrypto.so.1.1
	echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
	ldconfig -v
	openssl version
    rm /usr/local/openssl/lib/libcrypto.so.1.1
}

install_python(){
    log_info 'install python.'
    cd ${WORKSPACE}
	yum install epel-release -y
	yum groupinstall "Development tools" -y
	yum install bzip2-devel ncurses-devel gdbm-devel xz-devel \
		sqlite-devel libffi-devel libuuid-devel readline-devel \
		zlib-devel openssl-devel bzip2-devel -y

    version='3.10.7'
	wget -c https://mirrors.huaweicloud.com/python/${version}/Python-${version}.tgz
	tar -zxvf Python-${version}.tgz
    cd Python-${version}
    sed -i 's/PKG_CONFIG openssl /PKG_CONFIG openssl11 /g' configure
	./configure --prefix=/usr/local/python310 --enable-shared && make -j && make altinstall
    cd -
	cp /usr/local/python310/lib/libpython3.10.so.1.0 /usr/lib64/

	mv_bak /usr/bin/python3
	mv_bak /usr/bin/python
	mv_bak /usr/bin/pip3
	mv_bak /usr/bin/pip

	ln -s /usr/local/python310/bin/python3.10 /usr/bin/python3
	ln -s /usr/local/python310/bin/pip3.10 /usr/bin/pip3
	rm /usr/bin/python && ln -s /usr/bin/python3 /usr/bin/python
	rm /usr/bin/pip && ln -s /usr/bin/pip3 /usr/bin/pip
    # 恢复yum
	# rm /usr/bin/python && ln -s /usr/bin/python2 /usr/bin/python
	# rm /usr/bin/pip && ln -s /usr/bin/pip2 /usr/bin/pip
}

install_docker(){
    log_info 'install docker.'
    cd ${WORKSPACE}
    cp docker-ce.repo /etc/yum.repos.d/
    yum clean all && yum makecache
    yum install docker-ce -y

    docker_conf_dir=/etc/systemd/system/docker.service.d/
    mkdir $docker_conf_dir
    cp ${WORKSPACE}/http-proxy.conf $docker_conf_dir
    systemctl daemon-reload
    systemctl restart docker
}

install_node(){
    log_info 'install node.'
    cd ${WORKSPACE}
    version='v16.20.2'
    node_dir="node-${version}-linux-x64"
    wget -c https://nodejs.org/dist/${version}/${node_dir}.tar.gz
    tar -zxvf ${node_dir}.tar.gz

    mv_bak /usr/bin/node && ln -s ${WORKSPACE}/${node_dir}/bin/node /usr/bin/node
    mv_bak /usr/bin/npm && ln -s ${WORKSPACE}/${node_dir}/bin/npm /usr/bin/npm
    mv_bak /usr/bin/npx && ln -s ${WORKSPACE}/${node_dir}/bin/npx /usr/bin/npx
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

if [ $STAGE -eq 0 ]; then
    set_proxy $1
elif [ $STAGE -eq 1 ]; then
    pre_install
elif [ $STAGE -eq 2 ]; then
    tmux
    ctags
    others
    zsh_conf
elif [ $STAGE -eq 3 ]; then
    vim
    vim_plugins
elif [ $STAGE -eq 4 ]; then
    if [ x"$OS" = xCentOS ];then
        install_docker
        install_node
        install_openssl
        install_python
    else
        log_info "Not CentOS system."
        exit 1
    fi
fi
