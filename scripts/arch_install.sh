#!/usr/bin/env bash

trap exit SIGINT

# dbgprint(fmt, ...)
RED="\033[31m"
BLUE="\033[34m"
RESET="\033[0m"

dbg_error() {
  if [ $# -gt 0 ]; then
    fmt="$1"
    shift
    printf "${RED}[ERROR]:${RESET} $fmt\n" "$@"
  else
    echo "Error: signature match failed for dbg(fmt, ...)"
    exit 1
  fi
}

dbg_info() {
  if [ $# -gt 0 ]; then
    fmt="$1"
    shift
    printf "${BLUE}[INFO]:${RESET} $fmt\n" "$@"
  else
    echo "Error: signature match failed for dbg(fmt, ...)"
    exit 1
  fi
}

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
    dbg_error "Could not determine distro or platform."
    exit 1
  fi
}

if [ "$PWD" != "$HOME/dot/scripts" ]; then
  dbg_error "%s: execute from the "$PWD"/scripts directory" "$0"
  exit 1
fi

dbg_info "\n%s\n%s\n"\
  "$0: Running install, script will periodically prompt with sudo!"\
  "Terrible fucking code btw, no guarantee that this wont fuck everything :3"
read -p "Are you sure you want to continue (y/n): " prompt
if [[ "$prompt" == "n" ]]; then
  dbg_info "Exiting..."
  exit 0
fi

# set os environ vars determine platform
set_vars
if [[ "$OS" != "Manjaro Linux" ]]; then
  dbg_error "script only works for arch-based distros, exiting..."
  exit 1
fi

clear
dbg_info "Updating and installing dependencies"
sudo pacman --noconfirm -Syyuu
sudo pacman --noconfirm -S alacritty gdb git gcc cmake make pkg-config unzip \
  rofi polybar tmux zsh python python-pip fakeroot nitrogen yay which patch \
  earlyoom torbrowser-launcher torsocks proxychains-ng nmap hydra john hashcat \
  clang llvm docker docker-compose docker-buildx htop neofetch

yay --noconfirm -S ttf-unifont betterlockscreen

mkdir -p $HOME/.config
mkdir -p $HOME/.config/i3

dbg_info "Installing i3wm configuration"
if [ -e "$HOME/.config/i3/config" ]; then
  mv "$HOME/.config/i3/config" "$HOME/.config/i3/config.old"
fi
cp "../i3/config" "$HOME/.config/i3/config"

dbg_info "Removing previous configs for tmux, picom, alacritty, polybar, rofi"
rm -f "$HOME/.tmux.conf"
rm -rf "$HOME/.config/picom"
rm -rf "$HOME/.config/alacritty"
rm -rf "$HOME/.config/polybar"
rm -rf "$HOME/.config/rofi"

dbg_info "Install and setup betterlockscreen"
dbg_info "Patching i3exit to use betterlockscreen"
sudo cat "../i3exit" > "$(which i3exit)"

dbg_info "Installing alacritty config"
cp -r "../alacritty" "$HOME/.config"
dbg_info "Installing picom config"
cp -r "../picom" "$HOME/.config"
dbg_info "Installing polybar config"
cp -r "../polybar" "$HOME/.config"
dbg_info "Installing rofi config"
cp -r "../rofi" "$HOME/.config"
dbg_info "Installing tmux config"
cp "../tmux.conf" "$HOME/.tmux.conf"

dbg_info "Setup and installing pwndbg config"
pip install --break-system-packages --user pwn
git clone "https://github.com/pwndbg/pwndbg" "$HOME/pwndbg"
git clone "https://github.com/scwuaptx/Pwngdb.git" "$HOME/Pwngdb"
sh -c "$HOME/pwndbg/setup.sh" <<< "y" <<< "y"
cp "../gdbinit" "$HOME/.gdbinit"

dbg_info "Setup and installing radare2"
cp "../radare2rc" "$HOME/.radare2rc"
git clone "https://github.com/radareorg/radare2" "/tmp/radare2"
sh -c "/tmp/radare2/sys/install.sh"
dbg_info "Installing r2ghidra decompiler"
r2pm -ci r2ghidra r2ghidra-sleigh

dbg_info "Build and setup custom neovim config"
if pacman -Qs "neovim" >/dev/null; then
  sudo pacman -R "neovim"
fi
git clone "https://github.com/neovim/neovim" "/tmp/neovim"
make -C "/tmp/neovim" && sudo make -C "/tmp/neovim" install
if [ -e "$HOME/.config/nvim" ]; then
  mv "$HOME/.config/nvim" "$HOME/.config/nvim.old"
fi
cp -r "../nvim" "$HOME/.config"
neofetch
dbg_info "Script finished installing, rebooting in 5 seconds..."
sleep 5; reboot
