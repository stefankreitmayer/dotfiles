## Install (on a new computer)

### Brew

Install homebrew

`brew install git`

`brew install zsh`

`brew install ack`

`brew install ag`

`brew install ctags`

`brew install tree`

`brew install npm`

`brew install vim` to use the system clipboard, see http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing

### Vim, Zsh

[Install Vundle](https://github.com/VundleVim/Vundle.vim)

[Install OhMyZsh](https://github.com/robbyrussell/oh-my-zsh)


In home directory:

`ln dotfiles/vimrc .vimrc`

`rm .zshrc`

`ln dotfiles/zshrc .zshrc`

### Github

https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

### Rails

#### As admin user

`brew install rbenv`

[Follow some but not all of these steps](https://gorails.com/setup/osx/10.13-high-sierra)

Given a rails project, go to its directory and install the ruby version it says in the Gemfile or .ruby-version

e.g. `rbenv install 2.2.7` or whatever

##### For every ruby version

`gem install bundler`

`gem install rails`

##### Running a rails app

`bundle` or `bundle install`

#### As non-admin user

`rails s`
