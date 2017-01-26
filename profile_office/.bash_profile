# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.

declare -a extra_files=(
  ~/.path
  ~/.bash_prompt
  ~/.exports
  ~/.aliases
  ~/.functions
  ~/.extra
  ~/.boot2docker/init
)
for extra_file in "${extra_files[@]}"; do
  [ -r "$extra_file" ] && source "$extra_file"
done
unset extra_file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null
done

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2 | tr ' ' '\n')" scp sftp ssh

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults

# Autocomplete Grunt commands
which grunt &> /dev/null && eval "$(grunt --completion=bash)"

# If possible, add tab completion for many more commands
declare -a completion_files=(
  /etc/bash_completion
  /usr/share/bash-completion/bash_completion
  /usr/local/etc/bash_completion
)
for completion_file in "${completion_files[@]}"; do
  [ -f "$completion_file" ] && source "$completion_file"
done

# initialize rbenv
command -v rbenv &> /dev/null && eval "$(rbenv init -)"

# initialize nodenv
command -v nodenv &> /dev/null && eval "$(nodenv init -)"

# Allow terminal flow control chars in VIM
stty -ixon

# Set 256 colour terminal
test "$TERM" = xterm && export TERM=xterm-256color

# Rebuild SSH config (off partial configs in config.d)
cat ~/.ssh/config.d/* > ~/.ssh/config

# Create Go project workspace (if not exist)
[[ -d ~/workspace/golang ]] || mkdir -p ~/workspace/golang
## Set the GOPATH env variable
export GOPATH=~/workspace/golang
## Setup the skeleton directories
[[ -d ~/workspace/golang/bin ]] || mkdir -p ~/workspace/golang/bin
[[ -d ~/workspace/golang/src ]] || mkdir -p ~/workspace/golang/src
[[ -d ~/workspace/golang/pkg ]] || mkdir -p ~/workspace/golang/pkg
## Add to PATH
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

# Create Python project workspace
[[ -d ~/workspace/python ]] || mkdir -p ~/workspace/python
