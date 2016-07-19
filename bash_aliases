# general
alias \]="cd .."
alias cl="clear"
alias vi="vim"
alias pings="/bin/ping"
alias ping="/bin/ping -c 5 -i 0.5"
function swap () {
  local TMPFILE=tmp.$$
  mv "$1" $TMPFILE
  mv "$2" "$1"
  mv $TMPFILE "$2"
}


# ls

# bash configs
alias vbash="vim ~/.bashrc && source ~/.bashrc"
alias vbashprofile="vim ~/.bash_profile && source ~/.bash_profile"
alias vbashalias="vim ~/.bash_aliases && source ~/.bash_aliases"
alias sshconfig="vim ~/.ssh/config"


# IP getter
alias myip1="curl -s api.robjte.de/ip"
alias myip2="dig +short myip.opendns.com @resolver1.opendns.com"
function myip () {
  echo -n 'robjte.de => '
  myip1
  echo
  echo -n '  opendns => '
  myip2
}
