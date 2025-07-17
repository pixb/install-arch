#!/usr/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

function pacman_install() {
  if pacman -Qi "$1" &>/dev/null; then
    echo -e "${COLOR_GREEN}$1 is installed${COLOR_NC}"
  else
    echo -e "${COLOR_YELLOW}$1 is not install${COLOR_NC}"
    sudo pacman -S "$1" --noconfirm
  fi
}

function trizen_install() {
  if pacman -Qi "$1" &>/dev/null; then
    echo -e "${COLOR_GREEN}$1 is installed${COLOR_NC}"
  else
    echo -e "${COLOR_YELLOW}$1 is not install${COLOR_NC}"
    trizen -S "$1" --noconfirm
  fi
}

pacman_install greetd
pacman_install greetd-gtkgreet
pacman_install cage
pacman_install xdg-user-dirs
pacman_install xdg-utils
pacman_install xorg-xwayland
pacman_install qt5-wayland
pacman_install qt6-wayland

if [ -f /etc/greetd/config.toml ]; then
  echo -e "${COLOR_GREEN}backup /etc/greetd/config.toml backup.${COLOR_NC}."
  sudo mv /etc/greetd/config.toml /etc/greetd/config.toml.ori
fi

sudo ln -sf $(pwd)/config/greetd/config.toml /etc/greetd/config.toml
sudo cp $(pwd)/config/greetd/environments /etc/greetd/environments
sudo usermod -aG video greeter
