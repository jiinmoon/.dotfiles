# .dotfile: quick set-up archive

## NOTE: To Dos

- Create an automated script for quick-setup.
- Update for Apple M1 Silicon.
- Update Linux set-up guide.

## What is this?

Here are my currated personal configuration files archived for quickly setting
up a new development environment. It includes settings for various applications
such as X, ratpoison, Tmux, git, vim, and more.

## Set-up Guide

### For macOS (M1)

Before setting up our command line tools, here are some useful productivity
tools:

- `Rectangle`: window manager that replaced `Spectacle`.
- `Alfred`: general productivity application (quick launcher).
- `iTerm2`: better terminal.
- `KeePassXC`: password manager.
- `FireFox`: decent web browser.

Lastest macOS Big Sur by default ships with `zsh` which we would not bother
changing it as it works out of the box great.

We will first install `homebrew`, package manager.

```bash
$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
$ brew update
$ brew --version
```

Before we install various tools that we require, let's set up this
configurations first.

Eventually we want to clone this git repository. But let's first set up our
GitHub access for the new environment. You can find detailed process [here](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent).
In short, we will create a new public/private key-pair for SSH and register our
public key to the GitHub account.

```bash
$ ssh-keygen -t rsa -b 4096 -C "YOUR EMAIL HERE"
$ cat ~/.ssh/id_rsa.pub
```

Place the generated public key to your GitHub account as found
[here](https://docs.github.com/en/github/authenticating-to-github/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

Once finished, we can clone this git repo as follows:

```bash
$ git clone git@github.com:jiinmoon/.dotfiles.git ~/.dotfiles
```

Symbolically link the configurations files that you need as appropriate. Below
is an example:

```bash
$ ln -s ~/.dotfiles/formacos/.gitconfig ~/.gitconfig
$ ln -s ~/.dotfiles/formacos/.gitignore ~/.gitignore
$ ln -s ~/.dotfiles/formacos/.tmux.conf ~/.tmux.conf
$ ln -s ~/.dotfiles/formacos/.vimrc ~/.vimrc
$ ln -s ~/.dotfiles/formacos/.zprofile ~/.zprofile
$ ln -s ~/.dotfiles/formacos/.zshrc ~/.zshrc
```

#### Configuring `oh-my-zsh`

oh-my-zsh compliments the original `zsh` without having to tinker around too
much on the configuration. oh-my-zsh is installed as follows:

```bash
$ sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

There is a auto-completion plugin for oh-my-zsh called, `zsh-autosuggestions` that which requires additional set-up as follows:

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

#### Configuring `vim`

macOS ships with a vim already but this is not the version that we should be
working with.

```bash
$ /usr/bin/vim --version
VIM - Vi IMproved 8.2 (2019 Dec 12, compiled Dec 21 2020 20:40:21)
macOS version
Included patches: 1-850, 1972
Compiled by root@apple.com
...
```

For some of our vim plugins to function (particularly YCM), we require a vim
that is compiled with `+Python3` support. To do so, we either install `vim` or
`macvim`.

```bash
$ brew install vim
$ brew info vim
```

Check where newly installed `vim` has been placed unto - it would be most
likely found under `/opt/homebrew/bin`. A simple solution to replace the
preinstalled vim with this new vim would be to create an alias and place it
under `zsh` configuration file.

We use `vundle` as our vim plugin manager.

```bash
$ git clone http://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

Now, open `vim` and install the plugins with following command
`:PluginInstall`.

Notice that `YouCompleteMe` plugin has to be compiled to build its library in
order for auto-completion to take place. For this, we need to install
following:

```bash
$ brew install cmake python3 go nodejs java
$ sudo ln -sfn /usr/local/opt/openjdk/libexec/openjdk.jdk /Library/Java/JavaVirtualMachines/openjdk.jdk
```

Now, we compile YCM.

```bash
$ cd ~/.vim/bundle/YouCompleteMe
$ python3 install.py --all
```

Note that on Apple M1 based products, this may fail to build. This is a known
[issue](https://github.com/ycm-core/YouCompleteMe/issues/3823).

Common solution appears to be reinstall packages using ARM based homebrew;
then, compile YCM supplying additional arguments:

```bash
$ brew install llvm cmake python
$ sudo python3 install.py --all --system-libclang
```

#### Configuring `tmux`

All the necessary configurations are already within the `.tmux.conf` including
some useful keybinds and shortcuts.

```bash
$ brew install tmux
```

---

### For Linux

__As of current date (May, 26. 2021), below guide may be outdated__.

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

    $ ln -s /home/user-name/.dotfiles/forlinux/.xinitrc /home/user-name/.xinitrc
    $ ln -s /home/user-name/.dotfiles/forlinux/.gitconfig /home/user-name/.gitconfig

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

Note: now I recommend `xvim` instead for clipboard capability with
x environments.

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

For NodeJS, YCM requires proper set-up of **tern** which is now outdated and
uses **typescript engine** instead. But for now, tern works. This can be done
with either setting up `tern-project` file in each of the project directory, or
`tern-config` for global settings. Simplest solution is to:

    $ ln -s
    ~/.vim/bundle/YouCompleteMe/third_party/tern_runtime/node_modules/tern/.tern-project
    ~/.tern-project

**Taglist** plugin requires c-tags to work correctly - in some distros such
as debian does not have this.

    $ sudo apt install exuberant-ctags

**vim-go** plugin requires external binaries for nice things such as `:GoDef`
and so on. Install it in the vim by running the command `:GoInstallBinaries`.

Vim should work now.


---

Francisco Moon (Ji-In Moon)

jiinmoon@tutanota.com
