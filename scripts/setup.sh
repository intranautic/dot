#!/usr/bin/env sh


set_vars() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$NAME
  elif type lsb_release >/dev/null 2>&1; then
    OS=$(lsb_release -si)
  elif [ -f /etc/lsb-release ]; then
    . /etc/lsb-release
    OS=$DISTRIB_ID
  elif [ -f /etc/debian_version ]; then
    OS=Debian
  else
    echo "Could not determine distro or platform."
    exit 1
  fi
}

if [ "$PWD" != "$HOME/dot/scripts" ]; then
  printf "Error: execute %s from %s\n" "$0" "$PWD"
  exit 1
fi

# set os environ vars determine platform
set_vars


printf "%s: Running install script\n" "$0"
echo "Updating and installing dependencies"
#sudo pacman --noconfirm -Syyuu
#sudo pacman --noconfirm -S alacritty gdb git gcc cmake make pkg-config unzip \
#  rofi polybar tmux zsh python python-pip fakeroot 7zip nitrogen
#yay --noconfirm -S ttf-unifont

mkdir -p $HOME/.config

echo "Installing i3wm configuration"
if [ -e "$HOME/.config/i3/config" ]; then
  mv "$HOME/.config/i3/config" "$HOME/.config/i3/config.old"
fi
cp "../i3/config" "$HOME/.config/i3/config"

echo "Build and setup custom neovim config"
if pacman -Qs "neovim" >/dev/null; then
  sudo pacman -R "neovim"
fi
git clone "https://github.com/neovim/neovim" "/tmp/neovim"
make -C "/tmp/neovim" && sudo make -C "/tmp/neovim" install
if [ -e "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
fi
cp -r "../nvim" "$HOME/.config"

rm -rf "$HOME/.config/alacritty"
rm -rf "$HOME/.config/polybar"
rm -rf "$HOME/.config/rofi"

rm -rf "$HOME/.config/alacritty"
rm -rf "$HOME/.config/alacritty"


echo "Installing alacritty config"
cp -r "../alacritty" "$HOME/.config"

echo "Installing polybar config"


echo "Installing rofi config"
echo "Installing tmux config"
echo "Setup and installing pwngdb config"
#git clone https://github.com/pwndbg/pwndbg ~/pwndbg
#git clone https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb

echo "Install and setup betterlockscreen"
#yay --noconfirm -S betterlockscreen
echo "Patching i3exit to use betterlockscreen"
