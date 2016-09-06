#!/bin/bash

# install ZSH
sudo apt-get install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# copy theme and choose it
cp ./robjtede.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/
sed -i ".bak" "/^ZSH_THEME=/ s/ZSH_THEME=\".*\"/ZSH_THEME=\"robjtede\"/" ~/.zshrc

# uncomment and change update frequency
sed -i ".bak" "/^\(# \)\{0,1\}export UPDATE_ZSH_DAYS=[0-9]\{1,\}/ s/\(# \)\{0,1\}//" ~/.zshrc
sed -i ".bak" "/^\(# \)\{0,1\}export UPDATE_ZSH_DAYS=[0-9]\{1,\}/ s/[0-9]\{1,\}/6/" ~/.zshrc

# uncomment correction and waiting dots
sed -i ".bak" "/^\(# \)\{0,1\}ENABLE_CORRECTION=\{1,\}/ s/\(# \)\{0,1\}//" ~/.zshrc
sed -i ".bak" "/^\(# \)\{0,1\}COMPLETION_WAITING_DOTS=\{1,\}/ s/\(# \)\{0,1\}//" ~/.zshrc

# insert primary aliases
cat ./zaliases > ~/.zaliases

# choose aliases

echo -n "Do you want firewalld aliases? [y/N] "
read fwd
if [[ $fwd == "y" ]]; then
  echo >> ~/.zaliases
  cat ./partials/zaliases.firewalld >> ~/.zaliases
fi

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
# -i for osx compatibility
sed -i ".bak" "/^plugins=/ s/plugins=\(.*\)/plugins=\($plins\)/" ~/.zshrc
