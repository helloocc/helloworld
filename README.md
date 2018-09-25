# my-env

#### tmux backup
```
git clone https://github.com/tmux-plugins/tmux-continuum.git ~/.tmux

将以下内容添加到 ~/.tmux.conf：
run-shell ~/.tmux/tmux-continuum/continuum.tmux

Tmux Continuum 默认每隔 15 分钟备份一次，如果觉得频率过高，可以设置为 1 小时一次：
set -g @continuum-save-interval '60'

需要重载 Tmux 配置 tmux source-file ~/.tmux.conf
```
