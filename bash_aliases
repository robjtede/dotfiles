# general
alias \]="cd .."
alias cl="clear"
alias vi="vim"
alias pings="/bin/ping"
alias ping="/bin/ping -c 5 -i 0.5"

# ls
alias l="ls -lh"
alias ll="ls -lh"
alias la="ls -lAh"
alias lla="ls -lah"


# bash configs
alias vbash="vim ~/.bashrc && source ~/.bashrc"
alias vbashprofile="vim ~/.bash_profile && source ~/.bash_profile"
alias vbashalias="vim ~/.bash_aliases && source ~/.bash_aliases"
alias sshconfig="vim ~/.ssh/config"


# IP getter
alias myip1="curl -s api.robjte.de/ip"
alias myip2="dig +short myip.opendns.com @resolver1.opendns.com"
funtion myip () {
  echo 'robjte.de => '
  myip1
  echo
  echo '  opendns => '
  myip2
}
