#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

# proxy
http_proxy=http://192.168.123.187:10809
https_proxy=http://192.168.123.187:10809
ftp_proxy=http://192.168.123.187:10809
export http_proxy
export ftp_proxy
export https_proxy

if [ -d "${HOME}/dev" ]; then
	echo -e "${COLOR_GREEN}${HOME}/dev is exists${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}${HOME}/dev is not exists${COLOR_NC}"
	mkdir -p "${HOME}/dev"
fi
# install trizen
if command -v trizen &>/dev/null; then
	echo -e "${COLOR_GREEN}trizen is installed.${COLOR_NC}"
else
	if [ ! -d "${HOME}"/Downloads ]; then
		mkdir -p "${HOME}"/Downloads
	fi
	git clone https://aur.archlinux.org/trizen.git "${HOME}"/Downloads/trizen
	cd "${HOME}"/Downloads/trizen || exit
	makepkg -si
fi
if [ -d "${HOME}/dev/vimrc" ]; then
	echo -e "${COLOR_GREEN}echo vimrc is exists${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}echo vimrc is not exists${COLOR_NC}"
	git clone https://github.com/pixb/vimrc.git "${HOME}/dev/vimrc"
fi

if [ -e "${HOME}/.vimrc" ]; then
	echo -e "${COLOR_GREEN}${HOME}/.vimrc is exists${COLOR_NC}"
else
	echo -e "${COLOR_GREEN}${HOME}/.vimrc is not exists${COLOR_NC}"
	ln -sf "${HOME}/dev/vimrc/vimrc" "${HOME}"/.vimrc
fi

if pacman -Qi neovim >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}neovim is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}neovim is not install${COLOR_NC}"
	sudo pacman -S neovim --noconfirm
fi

if command -v ssh >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}openssh is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}openssh is not install${COLOR_NC}"
	sudo pacman -S openssh --noconfirm
fi

if [ -d "${HOME}"/.pyenv ]; then
	echo -e "${COLOR_GREEN}pyenv is installed${COLOR_NC}"
	export PATH=$HOME/.pyenv/bin:$PATH
	eval "$(pyenv init -)"
else
	echo -e "${COLOR_YELLOW}pyenv is not install${COLOR_NC}"
	git clone https://github.com/pyenv/pyenv.git "${HOME}"/.pyenv
	export PATH=$HOME/.pyenv/bin:$PATH
	eval "$(pyenv init -)"
fi
if command -v python3 >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}$(python3 --version) is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW} python3 is not install${COLOR_NC}"
	pyenv install 3.13.0
	pyenv global 3.13.0
fi
if pacman -Qi tk >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}tk is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}tk is not install${COLOR_NC}"
	sudo pacman -S tk --noconfirm
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

if pacman -Qi tmux >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}tmux is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}tmux is not install${COLOR_NC}"
	sudo pacman -S tmux --noconfirm
fi

if pacman -Qi go >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}go is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}go is not install${COLOR_NC}"
	sudo pacman -S go --noconfirm
fi
if pacman -Qi ripgrep >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}ripgrep is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}ripgrep is not install${COLOR_NC}"
	sudo pacman -S ripgrep --noconfirm
fi

if pacman -Qi ranger >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}ranger is intalled${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}ranger is not install${COLOR_NC}"
	pip3 install setuptools
	trizen -S ranger-git --noconfirm
fi
cp -r config/ranger "${HOME}"/.config

if [ -d "${HOME}"/dev/linux-demo ]; then
	echo -e "${COLOR_GREEN}${HOME}/dev/linux-demo is exist${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}clone linux-demo${COLOR_NC}"
	git clone git@github.com:pixb/linux-demo.git "${HOME}"/dev/linux-demo
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
