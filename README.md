<div align="center">

<h1>Setup</h1>
<strong>>> <i>Dotfiles & workspace setup</i> <<</strong><br><br>

![.ENV]
![macos-logo]
![homebrew]
</div>


This repository reflects my workspace setup. I like to keep my work machine as stateless
as possible; meaning I can completely wipe out the OS, start over everything from
scratch, and become productive within an hour at max. Here I've documented a few
building blocks of the orchestration, for example—dotfiles, configurations, scripts to
run after a new OS installation, and steps to carry out so that I don't find myself
fumbling for missing pieces while I'm working on something, etc.

## Work machine

```txt
                    'c.          rednafi@mac
                 ,xNMM.          -----------
               .OMMMMo           OS: macOS 13.4.1 22F2083 arm64
               OMMM0,            Host: Mac14,15
     .;loddo:' loolloddol;.      Kernel: 22.5.0
   cKMMMMMMMMMMNWMMMMMMMMMM0:    Uptime: 5 days, 4 hours, 37 mins
 .KMMMMMMMMMMMMMMMMMMMMMMMWd.    Packages: 22 (brew)
 XMMMMMMMMMMMMMMMMMMMMMMMX.      Shell: zsh 5.9
;MMMMMMMMMMMMMMMMMMMMMMMM:       Resolution: 1440x932
:MMMMMMMMMMMMMMMMMMMMMMMM:       DE: Aqua
.MMMMMMMMMMMMMMMMMMMMMMMMX.      WM: Quartz Compositor
 kMMMMMMMMMMMMMMMMMMMMMMMMWd.    WM Theme: Blue (Light)
 .XMMMMMMMMMMMMMMMMMMMMMMMMMMk   Terminal: Apple_Terminal
  .XMMMMMMMMMMMMMMMMMMMMMMMMK.   Terminal Font: JetBrainsMono-Regular
    kMMMMMMMMMMMMMMMMMMMMMMd     CPU: Apple M2
     ;KMMMMMMMWXXWMMMMMMMk.      GPU: Apple M2
       .cooc,.    .,coo:.        Memory: 2335MiB / 16384MiB
```

## OS settings

* OS                    : macOS
* Terminal              : xterm-256color
* Shell                 : zsh with a simple 5 lines custom plugin manager
* Mono font             : jetbrains mono regular

## OS pre installation steps

* Take a backup of the following entities and put them in a folder called `backup`:
    * `.ssh` directory
    * `.zshrc`, `.zsh_history`, `.zprofile`
    * `.gitconfig`
    * `.ovpn` config
    * `.env` files and the credentials of disparate projects

## OS post installation steps

### Create directory layout

* Work and personal project directory layout should always have the following structure:

    ```txt
    ~/canvas
    ├── company_a
    │   ├── project_1
    │   └── project_2
    ├── company_b
    │   ├── project_1
    │   └── project_2
    └── projects
        ├── project_1
        └── project_2
    ```
* To create the above project directory layout, run:

    ```sh
    mkdir -p ~/canvas/<company_name> && mkdir -p ~/canvas/projects
    ```
* Before starting to restore things, put the `backup` folder temporarily in the
`~/canvas/projects/` directory.

### Restore SSH

* Copy the backup ssh keys into the `~/.ssh` folder:

    ```sh
    cp -r backup/.ssh/* ~/.ssh
    ```
* Change folder permission:

    ```sh
    sudo chown -R $USER:$USER ~/.ssh
    chmod -R 700 ~/.ssh
    ```
* If you've changed the username from `rednafi` to anything else, in that case, you've
to regenerate the public ssh key from the private key.

    First copy the `id_rsa` private key to the `~/.ssh` folder and change the permission
    via the commands stated above. Then run:

    ```sh
    ssh-keygen -y -f ~/.ssh/id_rsa > ~/.ssh/id_rsa.pub
    ```

### Install tools

Although all of these tools are download via scripts, they still need some manual
supervision. That's why it's better to run them one by one instead of in a single go.

* Install Homebrew:

    ```sh
    /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

* By default, MacOS is shipped with a really old version of Bash for licensing issues.
Let's update that first:

    ```sh
    brew install bash
    ```
* Install Python. Python is installed with `asdf` CLI version manager. First, install
`asdf`:

    ```sh
    brew install asdf
    ```

    Add `asdf` Python plugin:

    ```sh
    asdf plugin-add python
    ```

    Install your preferred version of Python:

    ```sh
    asdf install python 3.11.4
    ```

    Set up global Python version:

    ```sh
    asdf global Python 3.11.4
    ```

* Similarly, install NodeJS and Golang by following the instructions [here][asdf-node].
Also, checkout the [tool-versions] config file to see how `asdf` managed CLIs are
configured.

* Install docker with [orbstack].

### Restore .zshrc & zsh_history

* Install zsh if it's not already installed:

    ```sh
    brew install zsh
    ```
* Change shell to zsh:

    ```sh
    sudo chsh -s $(command -v zsh)
    ```
* Overwrite `.zshrc`:

    ```sh
    cp ~/canvas/personal/backup/.zshrc ~/.zshrc
    ```
* Overwrite `.zsh_history`:

    ```sh
    cp ~/canvas/personal/backup/.zsh_history ~/.zsh_history
    ```

<div align="center">
<i> ✨ 🍰 ✨ </i>
</div>

[.env]: https://img.shields.io/static/v1?style=for-the-badge&message=ENV&color=555555&logo=.ENV&logoColor=ECD53F&label=
[macos-logo]: https://shields.io/badge/MacOS--1cf?logo=Apple&style=for-the-badge
[homebrew]: https://img.shields.io/static/v1?style=for-the-badge&message=brew&color=555555&logo=Homebrew&logoColor=ECD53F&label=
[asdf-node]: https://asdf-vm.com/guide/getting-started.html#install-the-plugin
[tool-versions]: ./.tool-versions
[orbstack]: https://docs.orbstack.dev/
