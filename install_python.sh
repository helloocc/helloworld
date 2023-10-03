#!/bin/bash
set -xe

mv_bak(){
    if [ -f $1 ];then
        mv $1 $1.bak
    fi
}

install_openssl(){
	wget https://www.openssl.org/source/openssl-1.1.1n.tar.gz
	tar -zxvf openssl-1.1.1n.tar.gz && cd openssl-1.1.1n
    ./config --prefix=/usr/local/openssl && make && make install
	mv_bak /usr/bin/openssl
	ln -sf /usr/local/openssl/bin/openssl /usr/bin/openssl
    mv_bak /usr/local/openssl/lib/libcrypto.so.1.1
	echo "/usr/local/openssl/lib" >> /etc/ld.so.conf
	ldconfig -v
	openssl version
}

install_python(){
	yum install epel-release -y
	yum groupinstall "Development tools" -y
	yum install bzip2-devel ncurses-devel gdbm-devel xz-devel \
		sqlite-devel libffi-devel libuuid-devel readline-devel \
		zlib-devel openssl-devel bzip2-devel -y

	wget -c https://mirrors.huaweicloud.com/python/3.10.7/Python-3.10.7.tgz
	tar -zxvf Python-3.10.7.tgz && cd Python-3.10.7
    sed -i 's/PKG_CONFIG openssl /PKG_CONFIG openssl11 /g' configure
	./configure --prefix=/usr/local/python310 --enable-shared && make -j && make altinstall
	cp /usr/local/python310/lib/libpython3.10.so.1.0 /usr/lib64/

	mv_bak /usr/bin/python3
	mv_bak /usr/bin/python
	mv_bak /usr/bin/pip3
	mv_bak /usr/bin/pip
	ln -s /usr/local/python310/bin/python3.10 /usr/bin/python3
	ln -s /usr/local/python310/bin/pip3.10 /usr/bin/pip3
	ln -s /usr/bin/python3 /usr/bin/python
	ln -s /usr/bin/pip3 /usr/bin/pip
    yum install virtualenv -y
}

install_docker(){
    cp docker-ce.repo /etc/yum.repos.d/
    yum clean all && yum makecache
    yum install docker-ce -y
    systemctl start docker
}

install_openssl
install_python
install_docker
