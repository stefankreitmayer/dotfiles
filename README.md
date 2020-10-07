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

Install [nvim](https://github.com/neovim/neovim/wiki/Installing-Neovim)

`brew install heroku/brew/heroku`

### Vim, Zsh

[Install Plug](https://github.com/junegunn/vim-plug#neovim)

[Install OhMyZsh](https://github.com/robbyrussell/oh-my-zsh)


In home directory:

`mkdir -p .config/nvim`

`ln dotfiles/init.vim .config/nvim/init.vim`

`rm .zshrc`

`ln dotfiles/zshrc .zshrc`

### Github

https://help.github.com/articles/adding-a-new-ssh-key-to-your-github-account/

### Rails

#### As admin user

`brew install rbenv`

Follow some (but not all) of the steps in [this how-to](https://gorails.com/setup/osx/10.13-high-sierra)

Given a rails project, go to its directory and install the ruby version it says in the Gemfile or .ruby-version

e.g. `rbenv install 2.2.7` or whatever

##### For every ruby version

`gem install bundler`

`gem install rails`

##### Running a rails app

`bundle` or `bundle install`

#### As non-admin user

`rake db:create`

`rake db:migrate`

`rails s`
