#!/bin/env bash
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

pacman_install i3status
