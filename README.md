<div align="center">

<h1>Setup</h1>
<strong>>> <i>Dotfiles & Workspace Setup</i> <<</strong><br><br>

![.ENV][1]
![macos-logo][2]
![homebrew][3]
</div>


This repository reflects my workspace setup. I like to keep my work machine as stateless
as possible; meaning I can completely wipe out the OS, start over everything from
scratch, and become productive within an hour at max. Here I've documented a few
building blocks of the orchestration, for example—dotfiles, configurations, scripts to
run after a new OS installation, and steps to carry out so that I don't find myself
fumbling for missing pieces while I'm working on something, etc.

## Work machine

```
                    'c.          rednafi@mbp.local
                 ,xNMM.          -----------------
               .OMMMMo           OS: macOS 13.0.1 22A400 arm64
               OMMM0,            Host: MacBookPro18,1
     .;loddo:' loolloddol;.      Kernel: 22.1.0
   cKMMMMMMMMMMNWMMMMMMMMMM0:    Uptime: 2 days, 8 hours, 6 mins
 .KMMMMMMMMMMMMMMMMMMMMMMMWd.    Packages: 28 (brew)
 XMMMMMMMMMMMMMMMMMMMMMMMX.      Shell: zsh 5.8.1
;MMMMMMMMMMMMMMMMMMMMMMMM:       Resolution: 1496x967
:MMMMMMMMMMMMMMMMMMMMMMMM:       DE: Aqua
.MMMMMMMMMMMMMMMMMMMMMMMMX.      WM: Rectangle
 kMMMMMMMMMMMMMMMMMMMMMMMMWd.    Terminal: Apple_Terminal
 .XMMMMMMMMMMMMMMMMMMMMMMMMMMk   Terminal Font: SFMono-Regular
  .XMMMMMMMMMMMMMMMMMMMMMMMMK.   CPU: Apple M1 Pro
    kMMMMMMMMMMMMMMMMMMMMMMd     GPU: Apple M1 Pro
     ;KMMMMMMMWXXWMMMMMMMk.      Memory: 3865MiB / 32768MiB
       .cooc,.    .,coo:.
```

## OS settings

* OS                    : MacOS Ventura
* Terminal              : Gnome terminal.
* Shell                 : Zsh with a simple 5 lines custom plugin manager.
* Mono Font             : SF Mono

## OS pre installation steps

* Take a backup of the following entities and put them in a folder called `backup`:
    * `.ssh` directory
    * `.zshrc`, `.zsh_history`, `.zprofile`
    * `.ovpn` config
    * `.env` files and the credentials of disparate projects

## OS post installation steps

### Create directory layout

* Work and personal project directory layout should always have the following structure:

    ```
    ~/Canvas
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
    mkdir -p ~/Canvas/<company_name> && mkdir -p ~/Canvas/personal
    ```
* Before starting to restore things, put the `backup` folder temporarily in the
`~/Canvas/personal/` directory.

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
* If you've changed the username from `rednafi` to anything else, in that case, you've
to regenerate the public ssh key from the private key.

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
    cp ~/Canvas/personal/backup/.zshrc ~/.zshrc
    ```
* Overwrite `.zsh_history`:

    ```
    cp ~/Canvas/personal/backup/.zsh_history ~/.zsh_history
    ```

### Install tools

Although all of these tools are download via scripts, they still need some manual
supervision. That's why it's better to run them one by one instead of in a single go.

* Install Homebrew:

    ```
    /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

* By default, macOS is shipped with a really old version of Bash for licensing issues.
Let's update that first:

    ```
    brew install bash
    ```
* Install Python. Python is installed with `asdf` CLI version manager. First, install
`asdf`:

    ```
    brew install asdf
    ```

    Add `asdf` Python plugin:

    ```
    asdf plugin-add python
    ```

    Install your preferred version of Python:

    ```
    asdf install python 3.11.1
    ```

    Set up global Python version:

    ```
    asdf global Python 3.11.1
    ```

* Similarly, install NodeJS and Golang by following the instructions [here][4]. Also,
checkout the `./.tool-versions` config file to see how `asdf` managed CLIs are
configured.

<div align="center">
<i> ✨ 🍰 ✨ </i>
</div>

[1]: https://img.shields.io/static/v1?style=for-the-badge&message=ENV&color=555555&logo=.ENV&logoColor=ECD53F&label=
[2]: https://shields.io/badge/MacOS--1cf?logo=Apple&style=for-the-badge
[3]: https://img.shields.io/static/v1?style=for-the-badge&message=brew&color=555555&logo=Homebrew&logoColor=ECD53F&label=
[4]: https://asdf-vm.com/guide/getting-started.html#install-the-plugin
