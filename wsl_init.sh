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
sudo pacman-key --init
sudo pacman-key --populate archlinux
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
	echo -e "${COLOR_GREEN}trizen is installed.${COLOR_NC}"
else
	git clone https://aur.archlinux.org/trizen.git "${HOME}"/Downloads/trizen
	cd "${HOME}"/Downloads/trizen || exit
	makepkg -si
fi

if [ -d "${HOME}"/dev ]; then
	echo -e "${COLOR_GREEN}${HOME}/dev is exist.${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}Create ${HOME}/dev path${COLOR_NC}"
	mkdir -p "${HOME}"/dev
fi

if [ -d "${HOME}"/dev/linux-demo ]; then
	echo -e "${COLOR_GREEN}${HOME}/dev/linux-demo is exist${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}clone linux-demo${COLOR_NC}"
	git clone git@github.com:pixb/linux-demo.git ${HOME}/dev/linux-demo
fi
export EDITOR=vim
if pacman -Qi rcm >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}rcm is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}rcm is not install${COLOR_NC}"
	trizen -S rcm --noconfirm
fi

if [ -d "${HOME}"/.dotfiles ]; then
	echo -e "${COLOR_GREEN}${HOME}/.dotfiles is exist${COLOR_NC}"
	cd "${HOME}" || exit
	rcup -t rcm
	rcup
else
	echo -e "${COLOR_YELLOW}clone .dotfiles${COLOR_NC}"
	git clone https://github.com/pixb/.dotfiles "${HOME}"/.dotfiles
	cd "${HOME}" || exit
	rcup -t rcm
	rcup
fi

if pacman -Qi fzf >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}fzf is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}fzf is not install${COLOR_NC}"
	sudo pacman -S fzf --noconfirm
fi

if pacman -Qi the_silver_searcher >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}the_silver_searcher is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}the_silver_searcher is not install${COLOR_NC}"
	sudo pacman -S the_silver_searcher --noconfirm
fi

if pacman -Qi nodejs >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}nodejs is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}nodejs is not install${COLOR_NC}"
	sudo pacman -S nodejs --noconfirm
fi

if pacman -Qi npm >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}npm is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}npm is not install${COLOR_NC}"
	sudo pacman -S npm --noconfirm
fi

if pacman -Qi ccat >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}ccat is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}ccat is not install${COLOR_NC}"
	# unset http_proxy https_proxy ftp_proxy
	trizen -S ccat --noconfirm
fi

if [ ! -d "${HOME}/.tmux" ]; then
	bash "${HOME}/dev/install-arch/tmux/config_tmux.sh"
fi

if pacman -Qi duf &>/dev/null; then
	echo -e "${COLOR_GREEN}duf is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}duf is not install${COLOR_NC}"
	trizen -S duf --noconfirm
fi

pacman_install hdparm
