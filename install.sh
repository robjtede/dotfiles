#!/bin/bash

echo detect OS
OS=$(uname -s)

echo install ZSH
sudo apt-get install zsh

echo install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo copy theme and select it
cp ./robjtede.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/
exp="/^ZSH_THEME=/s/ZSH_THEME=\".*\"/ZSH_THEME=\"robjtede\"/"
if [[ $OS == "Linux" ]]; then
  sed -ibak -r -e $exp -f ~/.zshrc
elif [[ $OS == "Darwin" ]]; then
  sed -i ".bak" -E -e $exp -f ~/.zshrc
fi


echo uncomment and change update frequency
exp1="/^\(# \)?export UPDATE_ZSH_DAYS=[0-9]+/s/^\(# \)?//"
exp2="/^\(# \)?export UPDATE_ZSH_DAYS=[0-9]+/s/[0-9]+/6/"

if [[ $OS == "Linux" ]]; then
  sed -ibak -r -e $exp1 -f ~/.zshrc
  sed -ibak -r -e $exp2 -f ~/.zshrc
elif [[ $OS == "Darwin" ]]; then
  sed -i ".bak" -E -e $exp1 -f ~/.zshrc
  sed -i ".bak" -E -e $exp2 -f ~/.zshrc
fi

echo uncomment correction and waiting dots
exp1="/^\(# \)?ENABLE_CORRECTION=/s/^\(# \)\?//"
exp2="/^\(# \)?COMPLETION_WAITING_DOTS=/s/^\(# \)\?//"

if [[ $OS == "Linux" ]]; then
  sed -ibak -r -e $exp1 -f ~/.zshrc
  sed -ibak -r -e $exp2 -f ~/.zshrc
elif [[ $OS == "Darwin" ]]; then
  sed -i ".bak" -E -e $exp1 -f ~/.zshrc
  sed -i ".bak" -E -e $exp2 -f ~/.zshrc
fi

echo copy aliases file
cp ./zaliases ~/.zaliases

echo choose optional aliases

echo -n "Do you want firewalld aliases? [y/N] "
read fwd
if [[ $fwd == "y" ]]; then
  echo >> ~/.zaliases
  cat ./partials/zaliases.firewalld >> ~/.zaliases
fi

echo source aliases
echo "source ~/.zaliases" >> ~/.zshrc

plins=""

echo "Choose ZSH plugins:"

# common aliases
echo -n "common aliases: [y/N] "
read caplugin
if [[ $caplin == "y" ]]; then plins="common-aliases $plins"; fi

# git
echo -n "git/gitfast/git-extras: [y/N] "
read gitplin
if [[ $gitplin == "y" ]]; then plins="git gitfast git-extras $plins"; fi

# ubuntu
echo -n "systemd: [y/N] "
read systemdplin
if [[ $systemdplin == "y" ]]; then plins="systemd $plins"; fi

# ubuntu
echo -n "ubuntu: [y/N] "
read ubuntuplin
if [[ $ubuntuplin == "y" ]]; then plins="ubuntu $plins"; fi

# rails
echo -n "rails: [y/N] "
read railsplin
if [[ $railsplin == "y" ]]; then plins="rails gem rake $plins"; fi

# centos
echo -n "yum: [y/N] "
read yumplin
if [[ $yumplin == "y" ]]; then plins="yum $plins"; fi

# osx
echo -n "osx/brew: [y/N] "
read osxplin
if [[ $osxplin == "y" ]]; then plins="osx brew $plins"; fi

# node development
echo -n "node/npm/gulp: [y/N] "
read nodeplin
if [[ $nodeplin == "y" ]]; then plins="node npm gulp $plins"; fi

# zsh-syntax-highlighting
echo -n "zsh-syntax-highlighting: [y/N] "
read zshshplin
if [[ $zshshplin == "y" ]]; then plins="zsh-syntax-highlighting $plins"; fi

# insert plugins into zshrc
exp="/^plugins=/s/plugins=\(.*\)/plugins=\($plins\)/"
if [[ $OS == "Linux" ]]; then
  sed -ibak -r -e $exp -f ~/.zshrc
elif [[ $OS == "Darwin" ]]; then
  sed -i ".bak" -E -e $exp -f ~/.zshrc
fi

# correct window titles in screen
echo '
# Set title of window to command
preexec () {
  echo -ne "\ek${1%% *}\e\\"
}
' >> ~/.zshrc


# copy dotfiles
cp ./screenrc ~/.screenrc
cp ./vimrc ~/.vimrc
cp ./iftoprc ~/.iftoprc
cp ./zprofile ~/.zprofile
