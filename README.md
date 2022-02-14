# dotfiles
This repository contains the configuration files for my development environment, including a bootstrap script to set everything up after a fresh Ubuntu installation. I have a
write-up about it on [my website](https://artfulbytes.com/devenv).

<img src="/.config/preview.png">

| Stats | |
| ----------- | ----------- |
| Distribution | Ubuntu 20.04 (64-bit) |
| Window manager | i3      |
| Editor | Vim |
| Terminal | Alacritty |
| Browser | Firefox |
| Dotfiles manager | yadm |
| Status bar | i3blocks |
| Font | Iosevka |
| Image viewer | sxiv |
| PDF viewer | zathura |
| Program launcher | j4-dmenu-desktop |
| File manager | Nautilus |
| Media player | VLC |
| Login manager | gdm3 |


## Setup
### 1. Install Ubuntu
I've only tried this on Ubuntu 20.04. Consider using a Virtual Machine if you just want to try it out.

Choices I make during installation:
* Minimal installation
* Single partition
* Computer name: Something short (e.g. desk, lpt, vm)
* Username: Something short (e.g. nik, ab)

### 2. Install yadm
After you have installed Ubuntu, install the packages needed for **yadm**.
```
sudo apt install curl git
```

Create a bin folder to store local binaries and scripts (e.g. **yadm**).
```
mkdir -p $HOME/bin
```

Download the latest **yadm** version.
```
curl -fLo "$HOME/bin/yadm" https://github.com/TheLocehiliosan/yadm/raw/master/yadm && chmod a+x "$HOME/bin/yadm"
```

Add **yadm** to the path in the current login session (alternatively, logout and in).
```
source ~/.profile
```

### 3. Clone this repo with yadm
Clone this repo with **yadm**
```
yadm clone https://github.com/niklasab/dotfiles
```
Write **no** when it asks you to run the bootstrap script.

In your home folder run
```
yadm status
```

There will be one conflicting file _.bashrc_. Overwrite _.bashrc_ by running
```
yadm checkout .bashrc
```

### 4. Run bootstrap script
Run the bootstrap script and go through all the steps
```
yadm bootstrap
```

Reboot and select gnome-flashback+i3 on the login manager (GDM3).

## Caution
This setup fits my workflow and might not fit yours, and I think it's better to be inspired by the setups of others than
trying to copy them. With that said, I hope you can find something useful from my setup.
