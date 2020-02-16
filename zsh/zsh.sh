#!/bin/bash

# ============================================
# SCRIPT FOR INSTALLATING ZSHRC DEPENDENCIES
# AUTHOR: REDOWAN DELOWAR
# ============================================

# installing or updating zsh
apt install zsh

# making zsh the default Shell
echo "Changing the default shell to zsh!"
chsh -s $(which zsh)

# load profile from zprofile
if grep -Fxq "[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'" ~/.zprofile
then
    echo "Zprofile is already updated!"
else
    echo "Updating zprofile..."
    echo "[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'" >> ~/.zprofile
fi

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


# install gogh terminal theme
# sudo apt-get install dconf-cli uuid-runtime
# bash -c  "$(curl -sLo- https://git.io/vQgMr)"

# update zshrc
echo """
# =====================
# MINIMALIST ZSHRC
# AUTHOR: REDNAFI
# =====================

# omz path
export ZSH="$HOME/.oh-my-zsh"

# theme settings
ZSH_THEME="tjkirch"

# pluging settings
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

# autosuggestion highlight
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=4"

# source omz
source $ZSH/oh-my-zsh.sh

#History setup
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZ

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell
setopt auto_list            # automatically list choices on ambiguous completion
setopt auto_menu            # automatically use menu completion
setopt always_to_end        # move cursor to end if word had one match

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''                                        # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate #enable approximate matches for completion

#disable auto correct
unsetopt correct_all

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.bash' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# server ip

""" >> ~/.zshrc
source ~/.zshrc
