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
  printf "%s: Error execute script from the "$PWD"/scripts directory\n" "$0"
  exit 1
fi

# set os environ vars determine platform
set_vars
if [[ "$OS" != "Manjaro Linux" ]]; then
  echo "Error: script only works for arch-based distros, exiting..."
  exit 1
fi

echo "$0: Running install, script will periodically prompt with sudo!"
echo "Terrible fucking code btw, no guarantee that this wont fuck everything :3"
read -p "Are you sure you want to continue (y/n): " prompt
if [[ "$prompt" == "n" ]]; then
  echo "Exiting..."
  exit 0
fi

echo "Updating and installing dependencies"
sudo pacman --noconfirm -Syyuu
sudo pacman --noconfirm -S alacritty gdb git gcc cmake make pkg-config unzip \
  rofi polybar tmux zsh python python-pip fakeroot nitrogen yay which
yay --noconfirm -S ttf-unifont betterlockscreen

mkdir -p $HOME/.config
mkdir -p $HOME/.config/i3

echo "Installing i3wm configuration"
if [ -e "$HOME/.config/i3/config" ]; then
  mv "$HOME/.config/i3/config" "$HOME/.config/i3/config.old"
fi
cp "../i3/config" "$HOME/.config/i3/config"

echo "Removing potential previous configs for tmux, picom, alacritty, polybar, rofi"
rm -f "$HOME/.tmux.conf"
rm -rf "$HOME/.config/picom"
rm -rf "$HOME/.config/alacritty"
rm -rf "$HOME/.config/polybar"
rm -rf "$HOME/.config/rofi"

echo "Install and setup betterlockscreen"
echo "Patching i3exit to use betterlockscreen"
sudo cat "../i3exit" > "$(which i3exit)"

echo "Installing alacritty config"
cp -r "../alacritty" "$HOME/.config"
echo "Installing picom config"
cp -r "../picom" "$HOME/.config"
echo "Installing polybar config"
cp -r "../polybar" "$HOME/.config"
echo "Installing rofi config"
cp -r "../rofi" "$HOME/.config"
echo "Installing tmux config"
cp "../tmux.conf" "$HOME/.tmux.conf"

echo "Setup and installing pwndbg config"
git clone "https://github.com/pwndbg/pwndbg" "~/pwndbg"
git clone "https://github.com/scwuaptx/Pwngdb.git" "~/Pwngdb"
sh -c "$HOME/pwndbg/setup.sh" <<< "y" <<< "y"
cp "../.gdbinit" "$HOME/.gdbinit"

echo "Setup and installing radare2"
cp "../radare2rc" "$HOME/.radare2rc"
git clone https://github.com/radareorg/radare2 ~/radare2
sh -c "$HOME/radare2/sys/install.sh"
echo "Installing r2ghidra decompiler"
r2pm -ci r2ghidra r2ghidra-sleigh

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

echo "Script finished installing, rebooting in 5 seconds..."
sleep 5; reboot