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
	cp ./res/vimrc/vimrc "${HOME}"/.vimrc
fi

if pacman -Qi wget >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}wget is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}wget is not install${COLOR_NC}"
	pacman -S wget --noconfirm
fi
if pacman -Qi linux-headers >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}linux-headers is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}linux-headers is not install${COLOR_NC}"
	pacman -S linux-headers --noconfirm
fi

if [ ${CPU} = "Intel" ]; then
	echo -e "${COLOR_GREEN}Install intel-ucode${COLOR_NC}"
	if pacman -Qi intel-ucode >/dev/null 2>&1; then
		echo -e "${COLOR_GREEN}intel-ucode is installed${COLOR_NC}"
	else
		echo -e "${COLOR_YELLOW}intel-ucode is not install${COLOR_NC}"
		pacman -S intel-ucode --noconfirm
	fi
else
	echo -e "${COLOR_GREEN}Install amd-ucode${COLOR_NC}"
	if pacman -Qi amd-ucode >/dev/null 2>&1; then
		echo -e "${COLOR_GREEN}amd-ucode is installed${COLOR_NC}"
	else
		echo -e "${COLOR_YELLOW}amd-ucode is not install${COLOR_NC}"
		pacman -S amd-ucode --noconfirm
	fi
fi
if pacman -Qi tree >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}tree is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}tree is not install${COLOR_NC}"
	pacman -S tree --noconfirm
fi
if pacman -Qi man >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}man is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}man is not install${COLOR_NC}"
	pacman -S man --noconfirm
fi
if pacman -Qi man >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}man is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}man is not install${COLOR_NC}"
	pacman -S man --noconfirm
fi
if pacman -Qi linux-lts >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}linux-lts is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}linux-lts is not install${COLOR_NC}"
	pacman -S linux-lts --noconfirm
fi
if pacman -Qi linux-lts-headers >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}linux-lts-headers is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}linux-lts-headers is not install${COLOR_NC}"
	pacman -S linux-lts-headers --noconfirm
fi
if pacman -Qi neovim >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}neovim is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}neovim is not install${COLOR_NC}"
	pacman -S neovim --noconfirm
fi
if pacman -Qi networkmanager >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}networkmanager is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}networkmanager is not install${COLOR_NC}"
	pacman -S networkmanager --noconfirm
fi
if pacman -Qi net-tools >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}net-tools is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}net-tools is not install${COLOR_NC}"
	pacman -S net-tools --noconfirm
fi
if pacman -Qi wpa_supplicant >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}wpa_supplicant is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}wpa_supplicant is not install${COLOR_NC}"
	pacman -S wpa_supplicant --noconfirm
fi
if pacman -Qi zsh >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}zsh is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}zsh is not install${COLOR_NC}"
	pacman -S zsh --noconfirm
fi
if pacman -Qi sudo >/dev/null 2>&1; then
	echo -e "${COLOR_GREEN}sudo is installed${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}sudo is not install${COLOR_NC}"
	pacman -S sudo --noconfirm
fi

if [ -e /etc/localtime ]; then
	echo -e "${COLOR_GREEN}/etc/localtime is exists${COLOR_NC}"
else
	echo -e "${COLOR_YELLOW}/etc/localtime is not exists${COLOR_NC}"
	ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
fi
hwclock --systohc
locale_file="/etc/locale.gen"
# check locale file
if [ -f "$locale_file" ]; then
	# 使用 sed 移除前面的注释符号
	sed -i 's/# *\(en_US.UTF-8 UTF-8\)/\1/' "$locale_file"
	sed -i 's/# *\(zh_CN.UTF-8 UTF-8\)/\1/' "$locale_file"
	echo "Success update /etc/locale.gen"
else
	echo -e "${COLOR_RED}Error:file $locale_file is not exists.${COLOR_NC}"
fi
locale-gen
echo LANG=en_US.UTF-8 >/etc/locale.conf

echo -e "${COLOR_GREEN}Plase input hostname:${COLOR_NC}"
read -r HOST_NAME
echo "${HOST_NAME}"

echo "${HOST_NAME}" >>/etc/hostname

cat <<EOF >/etc/hosts
127.0.0.1       localhost
::1             localhost
127.0.1.1       ${HOST_NAME}.localdomain ${HOST_NAME}
EOF

systemctl enable NetworkManager.service
echo -e "${COLOR_GREEN}Input root password${COLOR_NC}"
passwd
echo -e "${COLOR_GREEN}Plase input username:${COLOR_NC}"
read -r USER_NAME
if id "${USER_NAME}" &>/dev/null; then
	echo -e "${COLOR_GREEN}${USER_NAME} is exists${COLOR_NC}"
else
	useradd --create-home --groups wheel,root --shell /bin/zsh "${USER_NAME}"
	echo -e "${COLOR_GREEN}Input ${USER_NAME} password${COLOR_NC}"
	passwd "${USER_NAME}"
fi

sed -i 's/# *\(%wheel.*NOPASSWD: ALL\)/\1/' /etc/sudoers
