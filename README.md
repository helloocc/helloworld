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

set-option -g allow-rename on
```

#### tmux backup
```
git clone https://github.com/tmux-plugins/tmux-continuum.git ~/.tmux

将以下内容添加到 ~/.tmux.conf：
run-shell ~/.tmux/tmux-continuum/continuum.tmux

Tmux Continuum 默认每隔 15 分钟备份一次，如果觉得频率过高，可以设置为 1 小时一次：
set -g @continuum-save-interval '60'

需要重载 Tmux 配置 tmux source-file ~/.tmux.conf
```

#### zsh
```
yum install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

#### YouCompleteme
```
yum install epel-release
yum install python-devel libffi-devel gcc openssl-devel git python-pip
```
