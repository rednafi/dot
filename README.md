<h1>Setup<img
src='https://user-images.githubusercontent.com/30027932/138611579-9402e2c7-61c1-4cfa-a40f-665a73267533.png'
align='right' width='128' height='128'></h1>

<strong>>> <i>Dotfiles & Workspace Setup</i> <<</strong>

![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Gnome](https://img.shields.io/badge/Gnome-964B00?style=for-the-badge&logo=gnome&logoColor=white)
![bash](https://img.shields.io/badge/Bash-008080?style=for-the-badge&logo=shell&logoColor=white)
</div>

This repository reflects my workspace setup. I like to keep my work machine as stateless
as possible; meaning I can completely wipe out the OS, start over everything from
scratch, and become productive within an hour at max. Here I've documented a few building
blocks of the orchestration, for example—dotfiles, configurations, scripts to run after a
new OS installation, and steps to carry out so that I don't find myself fumbling for
missing pieces while I'm working on something, etc.

## Work machine

Dell XPS 2020 -> 15" 1080p | 8c 16T 3-5ghz CPU | 1TB NVME SSD | 32 GB 3000MHz DRAM

## OS settings

* OS                    : Ubuntu 22.04 LTS
* Terminal              : Gnome terminal.
* Shell                 : Zsh with a simple 5 lines custom plugin manager.
* System Font           : FreeSans Regular
* Mono Font             : Jetbrains Mono Regular

## OS pre installation steps

* Take a backup of the following entities and put them in a folder called `backup`:
    * `.ssh` directory
    * `.zshrc`, `.zsh_history`, `.zprofile`
    * `.ovpn` config
    * `.env` files and the credentials of disparate projects

## OS installation steps

* Taking snapshot backups of a work machine and going through a lengthy restoration
process is usually not worth the hassle.
* Download and install the third party drivers at the installation time. It usually
prevents pesky display issues after the first bootup.

## OS post installation steps

### Create directory layout

* Work and personal project directory layout should always have the following structure:

    ```
    ~/canvas
    ├── company_a
    │   ├── project_1
    │   └── project_2
    ├── company_b
    │   ├── project_1
    │   └── project_2
    └── personal
        ├── project_1
        └── project_2
    ```
* To create the above project directory layout, run:

    ```
    mkdir -p ~/canvas/<company_name> && mkdir -p ~/canvas/personal
    ```
* Before starting to restore things, put the `backup` folder temporarily in `~/canvas/
personal/` directory.

### Restore SSH

* Copy the backup ssh keys into the `~/.ssh` folder:

    ```
    cp -r backup/.ssh/* ~/.ssh
    ```
* Change folder permission:

    ```
    sudo chown -R $USER:$USER ~/.ssh
    chmod -R 700 ~/.ssh
    ```
* If you've changed the username from `rednafi` to anything else, in that case, you've to
regenerate the public ssh key from the private key.

    First copy the `id_rsa` private key to the `~/.ssh` folder and change the permission
    via the commands stated above. Then run:

    ```
    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
    ```

### Restore .zshrc & zsh_history

* Install Zsh if it's not already installed:

    ```
    sudo apt install zsh -y
    ```
* Change shell to Zsh:

    ```
    sudo chsh -s $(command -v zsh)
    ```
* Overwrite `.zshrc`:

    ```
    cp backup/.zshrc ~/.zshrc
    ```
* Overwrite `.zsh_history`:

    ```
    cp backup/.zsh_history ~/.zsh_history
    ```

### Install tools

Although all of these tools are download via scripts, they still need some manual
supervision. That's why it's better to run them one by one instead of in a single go.

* Install Jetbrains Mono font:

```
make install_fonts
```
* Install Python:

```
make install_python
```
* Install Golang:

```
make install_go
```
* Install misc tools. This should install:
    * code
    * curl
    * dnsutils
    * htop
    * jq
    * nano
    * net-tools
    * postman
    * telnet
    * vlc player
    * qbittorrent

```
make install_tools
```

## Issues & fixes

### Fix inconsistent Gnome settings

* Execute this to hide the fat and ugly Gnome title bar.

    ```
    gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
    ```
* Install and turn on [pixel-saver][1] Gnome extension to increase screen real estate.
* Disable the dock permanently.

    ```
    gnome-extensions disable ubuntu-dock@ubuntu.com
    ```

[1]: https://extensions.gnome.org/extension/723/pixel-saver/

<div align="center">
<i> ✨ 🍰 ✨ </i>
</div>
