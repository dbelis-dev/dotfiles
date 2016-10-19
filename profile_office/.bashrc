[ -n "$PS1" ] && source ~/.bash_profile

# are we an interactive shell?
if [ "$PS1" ]; then

  HOSTNAME=`hostname -s || echo unknown`

  # add cd history function
  [[ -f ${HOME}/bin/acd_func.sh ]] && . ${HOME}/bin/acd_func.sh
  ##################################
  # BEG History manipulation section

    # Set the size of the history file
    HISTSIZE=1000
    HISTFILESIZE=10000

    # Save timestamp info for every command
    export HISTTIMEFORMAT="[%F %T] ~~~ "

    # Dump the history file after every command
    shopt -s histappend
    [[ -f ${HOME}/bin/a_loghistory_func.sh ]] && . ${HOME}/bin/a_loghistory_func.sh

    # Specific history file per host
    export HISTFILE=$HOME/.history-$HOSTNAME

    save_last_command () {
        # Only want to do this once per process
        if [ -z "$SAVE_LAST" ]; then
            EOS=" # end session $USER@${HOSTNAME}:`tty`"
            export SAVE_LAST="done"
            if type _loghistory >/dev/null 2>&1; then
                _loghistory
                _loghistory -c "$EOS"
            else
                history -a
            fi
            /bin/echo -e "#`date +%s`\n$EOS" >> ${HISTFILE}
        fi
    }
    trap 'save_last_command' EXIT

  # END History manipulation section
  ##################################

  # Preload the working directory history list from the directory history
  if type -t hd >/dev/null && type -t cd_func >/dev/null; then
      { hd 20 ; pwd ; } | while read x ; do cd_func "$x" ; done
  fi
fi

[[ -s "/home/vagrant/.gvm/scripts/gvm" ]] && source "/home/vagrant/.gvm/scripts/gvm"

export PATH="/home/vagrant/.linuxbrew/bin:/home/vagrant/contx/dev_tools/scripts:/home/vagrant/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"
export MANPATH="/home/vagrant/.linuxbrew/share/man:"
export INFOPATH="/home/vagrant/.linuxbrew/share/info:"
## Set workspace for Go projects
export GOPATH=~/projects/golang
