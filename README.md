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
here](https://cdimage.debian.org/images/unofficial/non-free/images-including-firmware/10.4.0+nonfree/amd64/iso-dvd/). It also works in the Fedora32 workstation as well.

This set-up will use default graphical environment as a back-up, and instead
use `multi-user.target` to start *X* manually with
[ratpoison](http://www.nongnu.org/ratpoison/) window manager.

First, start the new TTY by pressing `CRTL+ALT+F[1-9]`.

Login as a root, and let's add our user to sudo group. Confirm that the user is
in sudo.

    $ usermod -aG sudo <user-name>
    $ groups <user-name>

Log back in as a user. Let's install packages that we require now. If use
appropriate package manager for your distro (i.e. `apt` for debian, `dnf` for
fedora, and etc).

    $ sudo apt update
    $ sudo apt install git vim-gtk xcompmgr tmux ...

Clone this `.dotfile` repository; to make it simple, let's set-up our GitHub
access for this new environment now as well. [Read more at
here](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent). Basically, we will create a new pub-private key for ssh, and register our public key to the GitHub account.

    $ ssh-keygen -t rsa -b 4096 -C "your-email-here"
    $ eval $(ssh-agent)
    $ ssh-add ~/.ssh/id_rsa
    $ git clone git@github.com:jiinmoon/.dotfiles.git ~/.dotfiles

Symbolic link the configuration files that you need as appropriate. Below are
few examples:

    $ ln -s /home/user-name/.dotfiles/.xinitrc /home/user-name/.xinitrc
    $ ln -s /home/user-name/.dotfiles/.gitconfig /home/user-name/.gitconfig

The basic-set up is done. Now, we will have to configure the some of the
applications manually.


Bash
----

Two plugins that we use here are `bash-completion` and `bash-git-prompt`.

`bash-completion` can be found as a package in debian.

    $ sudo apt install bash-completion

`bash-git-prompt` is used to display git status on the command prompt.

    $ git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt --depth=1

The source the `.bashrc` file, or restart the shell. Bash set-up is complete.

    $ source .bashrc


Tmux
----

This Tmux configuration does not deviate much from the default
settings, but few plugins are note-able. Mainly, we need Tmux Plugin Manager[
(TPM)](https://github.com/tmux-plugins/tpm) to install the necessary
plugins such as
[tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) and
[tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) which are
incredibly useful for saving and restoring tmux sessions.

    $ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

If already in the tmux session, then run following:

    $ tmux source ~/.tmux.conf

Otherwise, start the new tmux session. To install the plugins using tpm, press
`Prefix + I` where Prefix is the default escape key for Tmux (`CRTL + b`). The
tpm will indicate when the installation is finished.


Vim
---

The reason why we have installed `vim-gtk` is that we wanted to avoid the hassle
of compiling from the source. Vim can be obtained mainly as a binary
distribution, but in Debian/Ubuntu, `vim` package does not have a support for
`python` and `python3` enabled. This can be confirmed as follows:

    $ vim --version

If the output does not have `+python` or `+python3`, then it does not work with
many plugins that we are going to use - namely,
[Vundle](https://github.com/VundleVim/Vundle.vim) and
[YouCompleteMe](https://github.com/ycm-core/YouCompleteMe).

The needed plugins are already specified in the `.vimrc` already - thus, we
would first install the Vundle package manager.

    $ git clone http://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

Then, open `vim` and install using following command: `:PluginInstall`.

**YouCompleteMe** has to be compiled to build its library for auto-completion
to take place. **Assume we have installed all necessary components** (i.e. GO,
node, cmake, build-essentials, ...). For more, visit YCM git page.

For debian,

    $ sudo apt install python3-dev cmake build-esential

For fedora,

    $ sudo dnf install cmake make gcc-c++ python3-devel

Then, compile YCM.

    $ cd ~/.vim/bundle/YouCompleteMe
    $ python3 install.py --all

**Taglist** plugin requires c-tags to work correctly - in some distros such
as debian does not have this.

    $ sudo apt install exuberant-ctags

**vim-go** plugin requires external binaries for nice things such as `:GoDef`
and so on. Install it in the vim by running the command `:GoInstallBinaries`.

Vim should work now.



