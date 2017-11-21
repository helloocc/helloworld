# my-vim

#### vim
```
yum install python-devel python3-devel ruby-devel lua-devel libX11-devel gtk-devel gtk2-devel gtk3-devel ncurses-devel

git clone https://github.com/vim/vim.git
cd vim/
./configure --with-features=huge --enable-pythoninterp --with-python-config-dir=/usr/lib/python2.7/config/ --prefix=/usr
make
make install
```

#### Vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

#### Theme
```
cp ~/.vim/bundle/molokai/colors/molokai.vim ~/.vim/colors/
cp ~/.vim/bundle/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/
```

#### tmux.conf
```
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .
```



