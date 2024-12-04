#!/bin/bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

# config proxy
if grep -q "http_proxy" /etc/profile; then
	echo -e "${COLOR_GREEN}http_proxy is already set.${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}config http_proxy${COLOR_NC}"
	sudo sh -c 'cat<<EOF>>/etc/profile
  http_proxy=http://192.168.123.187:10809
  https_proxy=http://192.168.123.187:10809
  ftp_proxy=http://192.168.123.187:10809
  export http_proxy
  export ftp_proxy
  export https_proxy
  EOF'
fi
# proxy
http_proxy=http://192.168.123.187:10809
https_proxy=http://192.168.123.187:10809
ftp_proxy=http://192.168.123.187:10809
export http_proxy
export ftp_proxy
export https_proxy
if pacman -Qi base-devel >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}base-devel is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}base-devel is not install${COLOR_NC}"
	sudo pacman -S base-devel --noconfirm
fi

if pacman -Qi git >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}git is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}git is not install${COLOR_NC}"
	sudo pacman -S git --noconfirm
fi

if pacman -Qi neovim >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}neovim is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}neovim is not install${COLOR_NC}"
	sudo pacman -S neovim --noconfirm
fi

if pacman -Qi binutils >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}binutils is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}binutils is not install${COLOR_NC}"
	sudo pacman -S binutils --noconfirm
fi

if pacman -Qi debugedit >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}debugedit is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}debugedit is not install${COLOR_NC}"
	sudo pacman -S debugedit --noconfirm
fi

# install trizen
if command -v trizen &>/dev/null; then
	echo "trizen is installed."
else
	git clone https://aur.archlinux.org/trizen.git ${HOME}/Downloads/trizen
	cd ${HOME}/Downloads/trizen
	makepkg -si
fi

if [ -d ${HOME}/dev ]; then
	echo -e "${COLOR_GREEN}${HOME}/dev is exist.${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}Create ${HOME}/dev path${COLOR_NC}"
	mkdir -p ${HOME}/dev
fi

if [ -d ${HOME}/dev/linux-demo ]; then
	echo -e "${COLOR_GREEN}${HOME}/dev/linux-demo is exist${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}clone linux-demo${COLOR_NC}"
	git clone git@github.com:pixb/linux-demo.git ${HOME}/dev/linux-demo
fi
export EDITOR=vim
if pacma -Qi rcm >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}rcm is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}rcm is not install${COLOR_NC}"
	trizen -S rcm --noconfirm
fi

if [ -d ${HOME}/.dotfiles ]; then
	echo -e "${COLOR_GREEN}${HOME}/.dotfiles is exist${COLOR_NC}"
	cd ${HOME}
	rcup -t rcm
	rcup
else
	echo -e "${COLOR_YELLOW}clone .dotfiles${COLOR_NC}"
	git clone https://github.com/pixb/.dotfiles ${HOME}/.dotfiles
	cd ${HOME}
	rcup -t rcm
	rcup
fi

sudo pacman -S fzf --noconfirm
trizen -S ccat-git --noconfirm
sudo pacman -S the_silver_searcher --noconfirm
