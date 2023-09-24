# (.) dot

Dotfiles and workspace setup. GNU [stow] is used to manage the config files.


## Pre-reinstall

Before OS reinstallation:

* Check that the latest versions of the following entities are backed up in this repo:
    * `.ssh` directory (without the private key)
    * `.zshrc`, `.zsh_history`, `.zprofile`
    * `.gitconfig`
    * `.editorconfig`
    * `.ovpn` config
    * `.env` files and the credentials of disparate projects

## Post-reinstall

After OS reinstallation:

### Create directory layout

* Create the workflow directory:

    ```sh
    mkdir -p ~/canvas
    ```

* Clone this repo in the `canvas` directory:

    ```sh
    git clone git@github.com:rednafi/dot
    ```

### Run init script

* Head over to the `~/canvas/dot` folder.
* Run:
    ```sh
    chmod +x init.sh && ./init.sh
    ```

### Restore SSH

* Copy the private ssh key into the `~/.ssh` folder:
* Change directory permission:
    ```sh
    sudo chown -R $USER:$USER ~/.ssh
    chmod -R 700 ~/.ssh
    ```
[stow]: https://www.gnu.org/software/stow/
