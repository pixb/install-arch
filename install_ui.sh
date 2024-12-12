#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if command -v waybar >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}waybar is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}waybar is not installed${COLOR_NC}"
	sudo pacman -S waybar --noconfirm
fi

if command -v obsidian >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}bsidian is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}obsidian is not install${COLOR_NC}"
	sudo pacman -S obsidian --noconfirm
fi
if command -v google-chrome-stable >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}oogle-chrome-stable is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}google-chrome-stable is not install${COLOR_NC}"
	trizen -S google-chrome --noconfirm
fi

if command -v kate >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}kate is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}kate is not install${COLOR_NC}"
	sudo pacman -S kate --noconfirm
fi

if pacman -Qi otf-font-awesome >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}otf-font-awesome is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}otf-font-awesome is not install${COLOR_NC}"
	sudo pacman -S otf-font-awesome --noconfirm
fi
if pacman -Qi ttf-arimo-nerd >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}ttf-arimo-nerd is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}ttf-arimo-nerd is not install${COLOR_NC}"
	sudo pacman -S ttf-arimo-nerd --noconfirm
fi
if pacman -Qi noto-fonts >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}noto-fonts is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}noto-fonts is not install${COLOR_NC}"
	sudo pacman -S noto-fonts --noconfirm
fi

sudo usermod -aG input "$USER"
cp -r config/hypr "${HOME}"/.config/hypr
cp -r config/foot "${HOME}"/.config/foot
if pacman -Qi wmenu >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}wmenu is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}wmenu is not install${COLOR_NC}"
	sudo pacman -S wmenu --noconfirm
fi
if [ -f /usr/share/fonts/TTF/MonaspiceArNerdFont-Bold.otf ]; then
	echo -e "${COLOR_GREEN}Monaspice  Nerd Font is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}Monaspice Nerd Font is not install${COLOR_NC}"
	if [ -f ./res/Monaspace.zip ]; then
		echo -e "${COLOR_GREEN}./res/Monaspace.zip is exists${COLOR_GREEN}"
	else
		echo -e "${COLOR_YELLOW}./res/Monaspace.zip is not exists,download...${COLOR_NC}"
		wget -O ./res/Monaspace.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Monaspace.zip
	fi
	if [ -f ./res/Monaspace.zip ]; then
		unzip ./res/Monaspace.zip -d ./res/Monaspace
		sudo mv ./res/Monaspace/*.{ttf,otf} /usr/share/fonts/TTF
		fc-cache -fv
	fi
fi
if pacman -Qi dolphin >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}dolphin is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}dolphin is not install${COLOR_NC}"
	sudo pacman -S dolphin --noconfirm
fi
if pacman -Qi xorg-xlsclients >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}xorg-xlsclients is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}xorg-xlsclients is not install${COLOR_NC}"
	sudo pacman -S xorg-xlsclients --noconfirm
fi
