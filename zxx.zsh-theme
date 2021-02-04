autoload -U add-zsh-hook
autoload -Uz vcs_info

# curl -s https://gist.githubusercontent.com/HaleTom/89ffe32783f89f403bba96bd7bcd1263/raw/ | bash
if [[ $terminfo[colors] -ge 256 ]]; then
    turquoise="%F{115}"
    orange="%F{167}"
    purple="%F{135}"
    egg="%F{223}"
    hotpink="%F{161}"
    limegreen="%F{35}"
    blue="%F{74}"
else
    turquoise="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    limegreen="%F{green}"
    blue="%F{blue}"
fi


# Machine name.
function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || echo $HOST
}

# Directory info.
local current_dir='${PWD/#$HOME/~}'

# Git info.
local git_info='$(git_prompt_info)'
local git_last_commit='$(git log --pretty=format:"%h \"%s\"" -1 2> /dev/null)'
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}%{$reset_color%} %{$blue%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=" %{${orange}%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{${limegreen}%}✔︎"

# local time, color coded by last return code
#time_enabled="%(?.%{$fg[blue]%}.%{$fg[red]%})%*%{$reset_color%}"
time="%(?.%{$turquoise%}.%{$fg[red]%})%*%{$reset_color%}"

# Prompt format: \n USER@MACHINE in [DIRECTORY] git:BRANCH STATE MSG \n TIME >
#%{$fg_bold[blue]%}%n\
#%{$orange%}$(box_name) \
PROMPT="
%{$orange%}%n\
%{$fg[white]%}@\
%{$egg%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}[${current_dir}]%{$reset_color%} \
${git_info} \
${git_last_commit}
${time} \
%{$terminfo[bold]$fg[white]%}› %{$reset_color%}%f"

# Prompt format: \n # TIME USER at MACHINE in [DIRECTORY] on git:BRANCH STATE \n $
if [[ "$USER" == "root" ]]; then
PROMPT="
%{$fg[red]%}%* \
%{$terminfo[bold]$fg[blue]%}#%{$reset_color%} \
%{$bg[yellow]%}%{$fg[cyan]%}%n%{$reset_color%} \
%{$fg[white]%}at \
%{$fg[green]%}$(box_name) \
%{$fg[white]%}in \
%{$terminfo[bold]$fg[yellow]%}[${current_dir}]%{$reset_color%}\
${git_info}
%{$terminfo[bold]$fg[red]%}$ %{$reset_color%}"
fi

# elaborate exitcode on the right when >0
return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"
RPS1='${return_code}'
