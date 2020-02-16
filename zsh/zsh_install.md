Instructions were applied and tested on debian based linux (Ubuntu)

![screely-1579540100483](https://user-images.githubusercontent.com/30027932/72745523-d9549e00-3ba7-11ea-86e0-f156e876a28b.png)


## Install Z Shell
```bash
apt install zsh
```

## Making zsh as Default Shell
```bash
chsh -s $(which zsh)
```
## Load .profile from .zprofile
Add the following lines to `~/.zprofile` and source via `source ~/.zprofile`
```bash
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'
```

## Install Oh-My-Zsh
[Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## Set Pygmalion Theme
* Run `nano ~/.zshrc`
* Set `ZSH_THEME="pygmalion"`

## Set Firacode As the Default Terminal Font
Install Fira Code From [here.](https://github.com/tonsky/FiraCode)

## Set Syntax Highlighting
Using [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) to achieve this

* Clone this repository in oh-my-zsh's plugins directory
  ```bash
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  ```
* Activate the plugin in ~/.zshrc
  ```bash
  plugins=( [plugins...] zsh-syntax-highlighting)
  ```

## Set Suggestions
Using [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) to achieve this

* Clone this repository into $ZSH_CUSTOM/plugins (by default ~/.oh-my-zsh/custom/plugins)
  ```bash
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  ```
* Add the plugin to the list of plugins for Oh My Zsh to load (inside ~/.zshrc)
  ```bash
  plugins=(zsh-autosuggestions)
  ```

## Set Terminal Color (Optional)

* Install [Gogh](https://github.com/Mayccoll/Gogh)
* Select palenight theme

Start a new terminal session to see the effects!!! You might need to log out and log in again for the changes to be effective

## Updating OMZ
  ```bash
  upgrade_oh_my_zsh
  ```
## Uninstall zsh
```bash
sudo apt-get --purge remove zsh
```

## Uninstall OMZ
```bash
uninstall_oh_my_zsh
```
