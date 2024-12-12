#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if [ -d "${HOME}/dev" ]; then
	echo -e "${COLOR_GREEN}${HOME}/dev is exists${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}${HOME}/dev is not exists${COLOR_NC}"
	mkdir -p "${HOME}/dev"
fi
if [ -d "${HOME}/dev/vimrc" ]; then
	echo -e "${COLOR_GREEN}echo vimrc is exists${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}echo vimrc is not exists${COLOR_NC}"
	git clone https://github.com/pixb/vimrc.git "${HOME}/dev/vimrc"
	if [ -e "${HOME}/.vimrc" ]; then
		echo -e "${COLOR_GREEN}${HOME}/.vimrc is exists${COLOR_NC}"
	else
		echo -e "${COLOR_GREEN}${HOME}/.vimrc is not exists${COLOR_NC}"
		ln -sf "${HOME}/dev/vimrc" "${HOME}"/.vimrc
	fi
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
if pacman -Qi fcitx5 >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}fcitx5 is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}fcitx5 is not install${COLOR_NC}"
	sudo pacman -S fcitx5 --noconfirm
fi
if pacman -Qi fcitx5-chinese-addons >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}echo fcitx5-chinese-addons is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}echo fcitx5-chinese-addons is not install${COLOR_NC}"
	sudo pacman -S fcitx5-chinese-addons --noconfirm
fi
if pacman -Qi fcitx5-configtool >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}fcitx5-configtool is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}fcitx5-configtool is not install${COLOR_NC}"
	sudo pacman -S fcitx5-configtool --noconfirm
fi
if pacman -Qi fcitx5-gtk >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}fcitx5-gtk is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}fcitx5-gtk is not install${COLOR_NC}"
	sudo pacman -S fcitx5-gtk --noconfirm
fi
if pacman -Qi fcitx5-qt >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}fcitx5-qt is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}fcitx5-qt is not install${COLOR_NC}"
	sudo pacman -S fcitx5-qt
fi
if pacman -Qi fcitx5-skin-fluentdark-git >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}fcitx5-skin-fluentdark-git is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}fcitx5-skin-fluentdark-git is install${COLOR_NC}"
	trizen -S fcitx5-skin-fluentdark-git --noconfirm
fi
if pacman -Qi adwaita-qt5 >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}adwaita-qt5 is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}adwaita-qt5 is not install"
	trizen -S adwaita-qt5 --noconfirm
fi
if pacman -Qi adwaita-qt6 >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}adwaita-qt6 is installed"
else
	echo -e "${COLOR_YELLOW}adwaita-qt6 is not install"
	trizen -S adwaita-qt6 --noconfirm
fi
if pacman -Qi ranger >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}ranger is intalled${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}ranger is not install${COLOR_NC}"
	pip3 install setuptools
	trizen -S ranger-git --noconfirm
fi
cp -r config/ranger ${HOME}/.config
if pacman -Qi flameshot-git >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}flameshot-git is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}flameshot-git is not install"
	trizen -S flameshot-git --noconfirm
fi
if pacman -Qi grim >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}grim is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}grim is not install${COLOR_NC}"
	sudo pacman -S grim --noconfirm
fi
if pacman -Qi code >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}code is installend${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}code is not install${COLOR_NC}"
	sudo pacman -S code --noconfirm
fi
