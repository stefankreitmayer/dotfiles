zstyle :compinstall filename '~/.zshrc'

autoload -Uz compinit
compinit

# antigen plugins:
source ~/.antigen/antigen.zsh

# antigen bundle olivierverdier/zsh-git-prompt
# antigen use oh-my-zsh
# antigen theme robbyrussell/oh-my-zsh themes/fino

antigen apply

source /usr/local/etc/bash_completion.d/git-prompt.sh
precmd () { __git_ps1 "%{$fg_bold[cyan]%}%~%{$reset_color%} " "%# " "(%s) " }
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

# history
export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=$HISTSIZE

PATH=$PATH:~/bin:/usr/local/sbin

# By default, ^S freezes terminal output and ^Q resumes it. Disable that so
# that those keys can be used for other things.
unsetopt flowcontrol

export EDITOR=/usr/bin/vim

alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias cdf="cd ~/.dotfiles"

alias icem='ssh kreitmayer@icemserv.folkwang-uni.de'
alias 'slowinternet1=sudo ipfw pipe 1 config bw 20KBytes/s'
alias 'slowinternet2=sudo ipfw add 1 pipe 1 src-port 80'
alias 'fastinternet=sudo ipfw delete 1'
alias ll="ls -la"

alias g="git"
alias ga="git add"
alias gb="git branch -v"
alias gs="git status"
alias gc="git commit"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate --all"
alias glp="git log --oneline --graph --decorate --all -p"
alias gaa="git add -A ."
alias gap="git add -p"

alias sr='screen -r'
alias goals='cd ~/.goals && vim -p *'

function mcd() { mkdir -p $1 && cd $1 } # from garybernhardt/dotfiles

eval "$(rbenv init -)"
