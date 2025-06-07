# Archived

***I no longer use gnu-stow to manage my dotfiles. Managing the symlinks across multiple devices 
turned out to be a pain. Currently, using chezmoi to [manage the dotfiles].***


# [.] dot

Dotfiles and workspace setup on macOS. GNU [stow] is used to manage the config files.

## Pre-reinstall

Before OS reinstallation, perform the following steps:

* Check that the latest versions of the following entities are backed up in this repo:
    * `.ssh` directory (without the private key)
    * `.zshrc`, `.zsh_history`, `.zprofile`
    * `.gitconfig`
    * `.editorconfig`
    * `.env` files and the credentials of disparate projects

## Post-reinstall

After OS reinstallation, perform these steps in order:

### Create workspace directory

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

### Restore terminal settings

* Double click on the `~/.conf.terminal` file and save it as a profile.

[stow]: https://www.gnu.org/software/stow/
[manage the dotfiles]: https://github.com/rednafi/dotfiles
