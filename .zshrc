# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="afowler"

# See my shell_scripts repo for specs command
alias rspec="specs"

alias fs="foreman start"

alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="vim ~/.oh-my-zsh"

alias bex="bundle exec"

alias ios="open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"

# tmux
alias tls="tmux list-sessions"
alias ta="tmux attach -t"
alias tksn="tmux kill-session"
alias tksr="tmux kill-server"

# transfer
transfersh() {
  curl --progress-bar --upload-file $1 https://transfer.sh | pbcopy
}

# Git
alias gll="git log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gnb="git checkout -b"

gfb() {
  git fetch
  git checkout origin/$1
  gnb $1
}

grb() {
  git fetch
  git rebase $1
}

alias tmux="TERM=screen-256color-bce tmux"

alias rdtp="bundle exec rake db:test:prepare"

alias ack="ack-grep"

alias coffee="/home/Jack/.node/lib/node_modules/coffee-script/bin/coffee"

# Key bindings
# TODO: bind forward and backward word

# Set to this to use case-sensitive completion
#CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rbenv colorize rails)

source $ZSH/oh-my-zsh.sh

# Slurp function
# By James Duncombe
slurp() {
 if [[ -f .env ]]; then
    echo "### Setting up environment variables from .env"
    cat .env | grep -v '#' | while read line; do
      echo $line
      export $line
    done
  fi
}

# Customize to your needs...
export PATH="/usr/lib/lightdm/lightdm:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"



# nodejs
export PATH="/usr/local/share/npm/bin:$PATH"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source $HOME/.zshenv

# ruby-build
export PATH=$HOME/.rbenv/plugins/ruby-build/bin:$PATH

# postgres
export PATH=/usr/lib/postgresql/9.3/bin:$PATH

# Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export EDITOR=/usr/bin/vim

# npm
export PATH=$HOME/.node/bin:$PATH
export NODE_PATH=$NODE_PATH:/home/Jack/.node/lib/node_modules


export CLOSURE_PATH=/home/Jack/Projects/shell_scripts/compiler.jar



# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$HOME/bin:$PATH"

# James Amnesia code sharing
amn() {
  if [ $# -ge 1 -a ! -f $1 ]; then
    input=$(cat -)
    temp=$(mktemp)
    echo $input > $temp
    curl -sF "file=@$temp;filename=xyz.$1" https://amnesia.io/api/
    rm $temp
  elif [ $# -ge 1 -a -f $1 ]; then
    curl -sF "file=@$1" https://amnesia.io/api/
  else
    echo "No filename provided (amn [filename])"
    echo "Try:"
    echo "amn [filename]"
    echo "or"
    echo "pbpaste | amn [filetype]"
    echo "More info: https://amnesia.io"
    return 1
  fi
}
