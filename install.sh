#!/bin/bash

# install ZSH
sudo apt-get install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# insert primary aliases
cat zaliases > ~/.zaliases

echo "Do you want firewalld aliases?"
read fwd
if [[ $fwd == "y" ]]; then
  echo >> ~/.zaliases
  cat partials/zaliases.firewalld >> ~/.zaliases
fi


echo "source ~/.zaliases" >> ~/.zshrc
