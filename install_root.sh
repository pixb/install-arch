#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'
pacman-key --init
pacman-key --populate archlinux
CPU="Intel"
if grep -q AMD /proc/cpuinfo; then
	echo "AMD CPU"
	CPU="AMD"
fi

if grep -q Intel /proc/cpuinfo; then
	echo "Intel CPU"
	CPU="Intel"
fi

if pacman -Qi base-devel >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}base-devel is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}base-devel is not install${COLOR_NC}"
	pacman -S base-devel --noconfirm
fi

if pacman -Qi binutils >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}binutils is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}binutils is not install${COLOR_NC}"
	pacman -S binutils --noconfirm
fi

if pacman -Qi debugedit >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}debugedit is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}debugedit is not install${COLOR_NC}"
	pacman -S debugedit --noconfirm
fi

if pacman -Qi git >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}git is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}git is not install${COLOR_NC}"
	pacman -S git --noconfirm
fi
if pacman -Qi zip >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}zip is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}zip is not install${COLOR_NC}"
	pacman -S zip --noconfirm
fi
if pacman -Qi unzip >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}unzip is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}unzip is not install${COLOR_NC}"
	pacman -S unzip --noconfirm
fi

if pacman -Qi vim >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}vim is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}vim is not install${COLOR_NC}"
	pacman -S vim --noconfirm
fi

if [ -d res/vimrc ]; then
	echo -e "${COLOR_GREEN}echo ./res/vimrc is exists${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}echo ./res/vimrc is not exists${COLOR_NC}"
	git clone https://github.com/pixb/vimrc.git ./res/vimrc
fi
if [ -e "${HOME}/.vimrc" ]; then
	echo -e "${COLOR_GREEN}${HOME}/.vimrc is exists${COLOR_NC}"
else
	echo -e "${COLOR_GREEN}${HOME}/.vimrc is not exists${COLOR_NC}"
	cp .res/vimrc/vimrc "${HOME}"/.vimrc
fi

if pacman -Qi wget >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}wget is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}wget is not install${COLOR_NC}"
	pacman -S wget --noconfirm
fi

pacman -S linux-headers --noconfirm
if [ ${CPU} = "Intel" ]; then
	echo -e "${COLOR_GREEN}Install intel-ucode${COLOR_NC}"
	pacman -S intel-ucode --noconfirm
else
	echo -e "${COLOR_GREEN}Install amd-ucode${COLOR_NC}"
	pacman -S amd-ucode --noconfirm
fi
pacman -S tree --noconfirm
pacman -S man --noconfirm
pacman -S linux-lts --noconfirm
pacman -S linux-lts-headers --noconfirm
pacman -S neovim --noconfirm
pacman -S networkmanager --noconfirm
pacman -S net-tools --noconfirm
pacman -S wpa_supplicant --noconfirm
pacman -S zsh --noconfirm
