#!/bin/env bash
sudo pacman -S waybar --noconfirm
sudo pacman -S obsidian --noconfirm 
trizen -S google-chrome --noconfirm
sudo pacman -S kate --noconfirm
sudo pacman -S openssh --noconfirm
sudo pacman -S otf-font-awesome ttf-arimo-nerd noto-fonts --noconfirm
git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv
sudo pacman -S tk --noconfirm
sudo pacman -S fzf the_silver_searcher --noconfirm
sudo pacman -S tmux --noconfirm
sudo pacman -S go --noconfirm
sudo usermod -aG input $USER
cp -r config/hypr ${HOME}/.config/hypr
cp -r config/foot ${HOME}/.config/foot
sudo pacman -S wmenu
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/IBMPlexMono.zip
unzip IBMPlexMono.zip -d IBMPlexMono
sudo mv IBMPlexMono/*.ttf /usr/share/fonts/TTF
fc-cache -fv
rm -rf IBMPlexMono*
