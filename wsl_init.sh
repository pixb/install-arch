#!/bin/bash
# config proxy
if grep -q "http_proxy" /etc/profile;then
  echo "http_proxy is already set."
else
  echo "config http_proxy"
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
http_proxy=http://192.168.123.92:10809
https_proxy=http://192.168.123.92:10809
ftp_proxy=http://192.168.123.92:10809
export http_proxy
export ftp_proxy
export https_proxy
sudo pacman -S base-devel git neovim --noconfirm
sudo pacman -S binutils --noconfirm
sudo pacman -S debugedit --noconfirm
# install trizen
if command -v trizen&> /dev/null;then
  echo "trizen is installed."
else
  git clone https://aur.archlinux.org/trizen.git ${HOME}/Downloads/trizen
  cd ${HOME}/Downloads/trizen
  makepkg -si
fi
mkdir -p ${HOME}/dev
git clone git@github.com:pixb/linux-demo.git ${HOME}/dev/linux-demo
export EDITOR=vim
trizen -S rcm --noconfirm
git clone https://github.com/pixb/.dotfiles ${HOME}/.dotfiles
rcup -t rcm
rcup
sudo pacman -S fzf --noconfirm
trizen -S ccat-git --noconfirm
sudo pacman -S the_silver_searcher --noconfirm
