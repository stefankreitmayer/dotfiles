ZSH_DISABLE_COMPFIX=true
#
# Path to your oh-my-zsh installation.
export ZSH=/Users/stefan/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=200

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git git-prompt)

# User configuration

export PATH="/Users/stefan/.rbenv/shims:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/stefan/bin:/usr/local/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

source /usr/local/etc/bash_completion.d/git-prompt.sh
precmd () { __git_ps1 "%{$fg_bold[cyan]%}%~%{$reset_color%} " "%# " "(%s) " }
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWCOLORHINTS=1

# history
export HISTFILE=~/.histfile
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export EDITOR=/usr/bin/vim

alias ez="vim ~/.zshrc"
alias sz="source ~/.zshrc"
alias cdf="cd ~/.dotfiles"

alias icem='ssh kreitmayer@icemserv.folkwang-uni.de'
alias 'slowinternet1=sudo ipfw pipe 1 config bw 20KBytes/s'
alias 'slowinternet2=sudo ipfw add 1 pipe 1 src-port 80'
alias 'fastinternet=sudo ipfw delete 1'
alias ll="ls -la"

#alias vim="/usr/local/Cellar/vim/8.0.0559/bin/vim"
alias vi="vim"

alias g="git"
alias ga="git add"
alias gb="git branch -v"
alias gs="git status"
alias gc="echo Did you run your acceptance tests\? && git commit"
alias gco="git checkout"
alias gl="git log --oneline --graph --decorate --all"
alias glp="git log --oneline --graph --decorate --all -p"
alias gaa="git add -A ."
alias gap="git add -p"

alias sr='screen -r'
alias goals='cd ~/.goals && vim -p *'

alias pdfconcat='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'


function mcd() { mkdir -p $1 && cd $1 } # from garybernhardt/dotfiles

function p() {cd $(find projects -maxdepth 3 -type d | selecta)}


# export PATH="/Users/stefan/.rbenv/shims:${PATH}"
# source "/usr/local/Cellar/rbenv/1.1.0/libexec/../completions/rbenv.zsh"
rbenv rehash 2>/dev/null
rbenv() {
  typeset command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  rehash|shell)
    eval `rbenv "sh-$command" "$@"`;;
  *)
    command rbenv "$command" "$@";;
  esac
}
export PATH="/usr/local/opt/libxml2/bin:$PATH"
export PATH="/Users/localadmin/anaconda2/bin:$PATH"

export BATCAVE_API_KEY='6d96aa4b-4e26-4bf6-beb6-6f7531e0859f' # Username: 5 - Password khqkj76FhU7 - API docs are at: https://bats.cetools.org/v1/docs
source activate x5flaskheroku
