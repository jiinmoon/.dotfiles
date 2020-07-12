.dotfile: Quick Set-up Archive
==============================

TODO
----

- Make a complete list of packages required.
- Create a automated script for quick-setup.
- Add in *spacevim* and *spacemacs* setup.


What is this?
-------------

This is a collection of my personal configuration files archived for quick
set-up on a new development environment. It includes settings for various
applications such as X, ratpoison, Tmux, git, vim, and more.


Set-up Guide
------------

**The guide assumes that the base Linux installation has been completed**.
Recommendation is to use a fairly well packaged distribution with graphical
environment to avoid the hassle. For my current
set-up, I am using Debian GNU Linux with KDE Plasma, non-free image. [Found at
here](https://cdimage.debian.org/images/unofficial/non-free/images-including-firmware/10.4.0+nonfree/amd64/iso-dvd/). 

This set-up will use default graphical environment as a back-up, and instead
use `multi-user.target` to start *X* manually with *ratpoison* window manager.

First, start the new TTY by pressing `CRTL+ALT+F[1-9]`.

Login as a root, and let's add our user to sudo group. Confirm that the user is
in sudo.

    usermod -aG sudo <user-name>
    groups <user-name>

Log back in as a user. Let's install packages that we require now.

    sudo apt update
    sudo apt install git vim-gtk xcompmgr tmux ...

Clone this `.dotfile` repository; to make it simple, let's set-up our GitHub
access now as well. [Read more at
here](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent). Basically, we will create a new pub-private key for ssh, and register our public key to the GitHub account.

    sudo ssh-keygen -t rsa -b 4096 'my-email`
    eval $(ssh-agent)
    ssh-add ~/.ssh/id_rsa
    git clone git@github.com:jiinmoon/.dotfiles.git

Symbolic link the configuration files as appropriate. Below are few examples:

    ln -s /home/user-name/.dotfiles/.xinitrc /home/user-name/.xinitrc
    ln -s /home/user-name/.dotfiles/.gitconfig /home/user-name/.gitconfig

The basic-set up is done. Now, we will have to configure the some of the
applications manually.


Bash
----

Two plugins that we use here are `bash-completion` and `bash-git-prompt`.

`bash-completion` can be found as a package in debian.

    sudo apt install bash-completion

`bash-git-prompt` is used to display git status on the command prompt.

    git clone https://github.com/magicmonty/bash-git-prompt.git
    ~/.bash-git-prompt -depth=1

The source the `.bashrc` file and is complete.


Vim
---

The reason why we have installed `vim-gtk` is that we wanted to avoid the hassle
of compiling from the source. Vim can be obtained mainly as a binary
distribution, but in Debian/Ubuntu, `vim` package does not have a support for
`python` and `python3` enabled. This can be confirmed as follows:

    vim --version

If the output does not have `+python` or `+python3`, then it does not work with
many plugins that we are going to use - namely,
[Vundle](https://github.com/VundleVim/Vundle.vim) and
[YouCompleteMe](https://github.com/ycm-core/YouCompleteMe).

The needed plugins are already specified in the `.vimrc` already - thus, simply
install using following command inside the vim `:PluginInstall`.

**YouCompleteMe** has to be compiled to build its library for auto-completion
to take place. **Assume we have installed all necessary components** (i.e. GO,
node, cmake, build-essentials, ...). For more, visit YCM git page.

    cd ~/.vim/bundle/YouCompleteMe
    python3 install.py --all

Vim should work now.





