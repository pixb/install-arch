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

if [ -e $HOME/.sdkman/bin/sdkman-init.sh ]; then
  echo -e "${COLOR_GREEN}sdkman is installed${COLOR_NC}"
  source "$HOME/.sdkman/bin/sdkman-init.sh"
else
  echo -e "${COLOR_YELLOW}sdkman not init, init...${COLOR_NC}"
  curl -s "https://get.sdkman.io" | bash
fi

if command -v java &>/dev/null; then
  echo -e "${COLOR_GREEN}java is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}java is not install${COLOR_NC}"
  if command -v sdk &>/dev/null; then
    echo -e "${COLOR_GREEN}sdkman is installed${COLOR_GREEN}"
    sdk install java 11.0.23-tem
  else
    echo -e "${COLOR_YELLOW}sdknam is not install${COLOR_NC}"
  fi
fi

# proxy
http_proxy=http://192.168.123.88:10809
https_proxy=http://192.168.123.88:10809
ftp_proxy=http://192.168.123.88:10809
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

pacman_install neovim

if command -v ssh >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}openssh is installed${COLOR_NC}"
  sudo systemctl enable sshd.service
  sudo systemctl start sshd.service
else
  echo -e "${COLOR_YELLOW}openssh is not install${COLOR_NC}"
  sudo pacman -S openssh --noconfirm
  sudo systemctl enable sshd.service
  sudo systemctl start sshd.service
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
pacman_install tk
pacman_install fzf
pacman_install the_silver_searcher
pacman_install tmux
pacman_install go
pacman_install ripgrep --noconfirm
pacman_install lazygit
pacman_install imagemagick
pacman_install highlight
pacman_install p7zip
pacman_install rsync

if pacman -Qi ranger >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}ranger is intalled${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}ranger is not install${COLOR_NC}"
  pip3 install setuptools
  trizen -S ranger-git --noconfirm
fi

if [ ! -d "${HOME}/.config" ]; then
  mkdir -p "${HOME}/.config"
fi

ln -sf "${HOME}/dev/install-arch/config/ranger" "${HOME}/.config/ranger"

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

if [ ! -d "${HOME}/.config/nvim" ]; then
  git clone https://github.com/pixb/nvimlua.git ~/.config/nvim
fi

trizen_install fastfetch
pacman_install gdb
pacman_install gcc
pacman_install cmake
pacman_install meson
pacman_install htop
pacman_install btop
pacman_install duf

if [ ! -d $HOME/.tmux ]; then
  bash $HOME/dev/install-arch/tmux/config_tmux.sh
fi

pacman_install bc

if command -v pkgfile &>/dev/null; then
  echo -e "${COLOR_GREEN}pkgfile is installed${COLOR_NC}"
  sudo pkgfile --update
else
  echo -e "${COLOR_YELLOW}pkgfile is not install${COLOR_NC}"
  sudo pacman -S pkgfile --noconfirm
fi
pacman_install openbsd-netcat

pacman_install docker
pacman_install docker-compose
if [ ! -d /etc/docker ]; then
  sudo mkdir -p /etc/docker
fi
if ! grep -q cf-workers /etc/docker/daemon.json; then
  sudo tee -a /etc/docker/daemon.json <<EOF
{
  "registry-mirrors": ["https://cf-workers-docker-io-682.pages.dev/"]
}
EOF
fi

sudo systemctl enable docker
sudo systemctl start docker
