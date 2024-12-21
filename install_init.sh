#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'
pacman-key --init
pacman-key --populate archlinux
if command -v ssh >/dev/null 2>&1; then
  echo "${COLOR_GREEN}ssh is installed${COLOR_NC}"
else
  echo "${COLOR_YELLOW}ssh is not install${COLOR_NC}"
  pacman -S openssh --noconfirm
  systemctl enable sshd
  systemctl start sshd
fi
