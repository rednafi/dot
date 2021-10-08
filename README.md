<div align="center">

![img](./art/logo.png)

<strong>>> <i>Dotfiles & Workspace Setup</i> <<</strong>

</div>

This repository reflects the setup of my workspace. I like to keep my work machine as stateless as possible; meaning I can completely wipe out the OS, start everything from scratch, and become productive within an hour at max. Here I've documented a few building blocks of my system, for example—dotfiles, configurations, scripts to run after a new OS installation, steps to carry out so that I don't find myself fumbling for missing pieces while I'm working on something, etc.

Also, I use this repository to keep my tool proliferation in check. As SWEs, we tend to keep adding plethora of tools to our toolchain which often results in a irreproducible and unmaintainable workflow. Simplicity spawns sophistry.

## Work Machine

Dell XPS 2020 -> 15" 1080p | 8c 16T 3-5ghz CPU | 1TB NVME SSD | 32 GB 3000MHz DRAM

## OS Settings

* OS                    : Ubuntu 20.04 LTS
* System Zoom           : 1.25, change via `gnome-tweaks`
* System Font           : FreeSans Regular
* Mono Font             : Jetbrains Mono Regular
* Terminal font size    : 18

## OS Pre Installation Steps

* Take a backup of the following entities and put them in a folder called `backup`:
    * `.ssh` directory
    * `.bashrc` and `.bash_history`
    * `.ovpn` config


## OS Post Installation Steps

### 🔐 Restore SSH

* Copy the backup ssh keys into the `~/.ssh` folder:

    ```
    cp -r backup/.ssh/* ~/.ssh
    ```

* Change folder permission:

    ```
    sudo chown -R $USER:$USER ~/.ssh
    chmod -R 700 ~/.ssh
    ```

* If you've changed the username from `rednafi` to anything else, in that case you've to regenerate the public ssh key from the private key.

    First copy the `id_rsa` private key to the `~/.ssh` folder and change the permisison via the commands stated above. Then run:

    ```
    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
    ```

* Put all the database `*.pem` keys in the `~/.ssh` folder.

### Restore Bashrc & Bash History

* Change shell to Bash if set something else:
    ```
    sudo chsh -s $(which bash)
    ```
* Overwrite `.bashrc`.
    ```
    cp .bashrc ~/.bashrc
    ```
* Overwrite `.bash_history`.
    ```
    cp .bash_history ~/.bash_history
    ```

### ⚙️ Install Fonts

* Install Jetbrains Mono font:

```
$ curl -OJL https://download.jetbrains.com/fonts/JetBrainsMono-2.225.zip
$ unzip ./JetBrainsMono-2.225.zip -d /usr/share/fonts
$ fc-cache -f -v
```


## Issues & Fixes

### 🪑 Fix Ctrl + Shift + E Hijacking in VSCode

This happens due to an obscure setting in IBus. To solve this:

* Run:
    ```
    ibus-setup
    ```
* Go to the `Emoji` tab and delete the shortcut for emoji-annotation.

### Fix Inconsistent Gnome Settings

* Execute this to hide the fat and ugly Gnome titlebar.

    ```
    gsettings set org.gnome.Terminal.Legacy.Settings headerbar false
    ```

* `Ctrl+Tab` & `Ctrl+Shift+Tab` to Switch Between Gnome Terminal Tabs.

    ```
    gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ next-tab '<Primary>Tab' &&
    gsettings set org.gnome.Terminal.Legacy.Keybindings:/org/gnome/terminal/legacy/keybindings/ prev-tab '<Primary><Shift>Tab'
    ```

### 🪑 Fix Ubuntu Mirror Issues

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

<div align="center">
<i> ✨ 🍰 ✨ </i>
</div>
