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
