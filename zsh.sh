#!/bin/bash

# installing or updating zsh
apt install zsh

# making zsh the default Shell
echo "Changing the default shell to zsh!"
chsh -s $(which zsh)

# load profile from zprolie
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# install oh-my-zsh
if [[ -d "$HOME/.oh-my-zsh" ]]
then
    echo "Oh-My-Zsh is already installed!"
else
    echo "Installing Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi


# install syntax highlighter
if [[ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]]
then
    echo "Syntax Highlighter is already installed!"
else
    echo "Installing Syntax Highlighter..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi


# install suggestions
if [[ -d "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]]
then
    echo "Auto Suggestion is already installed!"
else
    echo "Installing Auto Suggestion..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi


#install gogh terminal theme
sudo apt-get install dconf-cli uuid-runtime
bash -c  "$(curl -sLo- https://git.io/vQgMr)"


