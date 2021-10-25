<h1>Setup<img src='https://user-images.githubusercontent.com/30027932/138611579-9402e2c7-61c1-4cfa-a40f-665a73267533.png' align='right' width='128' height='128'></h1>

<strong>>> <i>Dotfiles & Workspace Setup</i> <<</strong>

![Ubuntu](https://img.shields.io/badge/Ubuntu-E95420?style=for-the-badge&logo=ubuntu&logoColor=white)
![Gnome](https://img.shields.io/badge/Gnome-964B00?style=for-the-badge&logo=gnome&logoColor=white)
![bash](https://img.shields.io/badge/Bash-008080?style=for-the-badge&logo=shell&logoColor=white)
</div>


This repository reflects the setup of my workspace. I like to keep my work machine as stateless as possible; meaning I can completely wipe out the OS, start over everything from scratch, and become productive within an hour at max. Here I've documented a few building blocks of my system, for example—dotfiles, configurations, scripts to run after a new OS installation, steps to carry out so that I don't find myself fumbling for missing pieces while I'm working on something, etc.

Also, I use this repository to keep my tool proliferation in check. As SWEs, we tend to keep adding a plethora of tools to our toolchain which often results in an irreproducible and unmaintainable workflow. Simplicity spawns sophistry.

## Work Machine

Dell XPS 2020 -> 15" 1080p | 8c 16T 3-5ghz CPU | 1TB NVME SSD | 32 GB 3000MHz DRAM

## OS Settings

* OS                    : Ubuntu 20.04 LTS
* Terminal              : Gnome terminal running plain Bash
* System Zoom           : 1.25, change via `gnome-tweaks`
* System Font           : FreeSans Regular
* Mono Font             : Jetbrains Mono Regular
* Terminal font size    : 18

## OS Pre Installation Steps

* Take a backup of the following entities and put them in a folder called `backup`:

    * `.ssh` directory
    * `.bashrc` and `.bash_history`
    * `.ovpn` config
    * `.env` files and credentials of different projects

## OS Post Installation Steps

### Create Directory Layout

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

* Before starting to restore things, put the `backup` folder temporarily in `~/canvas/personal/` directory.

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

* If you've changed the username from `rednafi` to anything else, in that case, you've to regenerate the public ssh key from the private key.

    First copy the `id_rsa` private key to the `~/.ssh` folder and change the permission via the commands stated above. Then run:

    ```
    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
    ```

### Restore Bashrc & Bash History

* Change shell to Bash if set something else:
    ```
    sudo chsh -s $(which bash)
    ```
* Overwrite `.bashrc`.
    ```
    cp backup/.bashrc ~/.bashrc
    ```
* Overwrite `.bash_history`.
    ```
    cp backup/.bash_history ~/.bash_history
    ```

### Install Tools

Although all of these tools are download via scripts, they still need some manual supervision. That's why it's better to run them one by one instead of in a single go.

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
    * dbeaver
    * dnsutils
    * docker
    * htop
    * jq
    * nano
    * net-tools
    * postman
    * telnet
```
make install_tools
```

## Issues & Fixes

### Fix Ctrl + Shift + E Hijacking in VSCode

This happens due to an obscure setting in IBus. To solve this:

* Run:
    ```
    ibus-setup
    ```
* Go to the `Emoji` tab and delete the shortcut for emoji annotation.

### Fix Inconsistent Gnome Settings

* Execute this to hide the fat and ugly Gnome title bar.

    ```
    gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
    ```

* `Ctrl+Tab` & `Ctrl+Shift+Tab` to Switch Between Gnome Terminal Tabs.

    ```
    gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab' &&
    gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'
    ```

### Fix Ubuntu Mirror Issues

* Select mirror server from [here](https://launchpad.net/ubuntu/+archivemirrors).

* Add mirror server to `/etc/apt/sources.list` and reboot. If the new mirror server isn't picked up by the OS, try selectively commenting out other servers in the file. Here's a sample `sources.list` file:

    ```
    # See http://help.ubuntu.com/community/UpgradeNotes for how to upgrade to
    # newer versions of the distribution.
    deb http://bd.archive.ubuntu.com/ubuntu/ focal main restricted
    # deb-src http://bd.archive.ubuntu.com/ubuntu/ focal main restricted

    ## Major bug fix updates produced after the final release of the
    ## distribution.
    deb http://bd.archive.ubuntu.com/ubuntu/ focal-updates main restricted
    # deb-src http://bd.archive.ubuntu.com/ubuntu/ focal-updates main restricted
    ```

##

<div align="center">
<i> ✨ 🍰 ✨ </i>
</div>
