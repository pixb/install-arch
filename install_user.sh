#!/bin/env bash
if command -v waybar >/dev/null 2>&1; then
  echo "waybar is installed"
else
  echo "waybar is not installed"
  sudo pacman -S waybar --noconfirm
fi

if command -v obsidian >/dev/null 2>&1; then
  echo "obsidian is installed"
else
  echo "obsidian is not install"
  sudo pacman -S obsidian --noconfirm
fi
if command -v google-chrome-stable >/dev/null 2>&1; then
  echo "google-chrome-stable is installed"
else
  echo "google-chrome-stable is not install"
  trizen -S google-chrome --noconfirm
fi

if command -v kate >/dev/null 2>&1; then
  echo "kate is installed"
else
  echo "kate is not install"
  sudo pacman -S kate --noconfirm
fi
if command -v ssh >/dev/null 2>&1; then
  echo "openssh is installed"
else
  echo "openssh is not install"
  sudo pacman -S openssh --noconfirm
fi
if pacman -Qi otf-font-awesome >/dev/null 2>&1; then
  echo "otf-font-awesome is installed"
else
  echo "otf-font-awesome is not install"
  sudo pacman -S otf-font-awesome --noconfirm
fi
if pacman -Qi ttf-arimo-nerd >/dev/null 2>&1; then
  echo "ttf-arimo-nerd is installed"
else
  echo "ttf-arimo-nerd is not install"
  sudo pacman -S ttf-arimo-nerd --noconfirm
fi
if pacman -Qi noto-fonts >/dev/null 2>&1; then
  echo "noto-fonts is installed"
else
  echo "noto-fonts is not install"
  sudo pacman -S noto-fonts --noconfirm
fi
if [ -d ${HOME}/.pyenv ]; then
  echo "pyenv is installed"
else
  echo "pyenv is not install"
  git clone https://github.com/pyenv/pyenv.git ${HOME}/.pyenv
fi
if pacman -Qi tk >/dev/null 2>&1; then
  echo "tk is installed"
else
  echo "tk is not install"
  sudo pacman -S tk --noconfirm
fi
if pacman -Qi fzf >/dev/null 2>&1; then
  echo "fzf is installed"
else
  echo "fzf is not install"
  sudo pacman -S fzf --noconfirm
fi

if pacman -Qi the_silver_searcher >/dev/null 2>&1; then
  echo "the_silver_searcher is installed"
else
  echo "the_silver_searcher is not install"
  sudo pacman -S the_silver_searcher --noconfirm
fi

if pacman -Qi tmux >/dev/null 2>&1; then
  echo "tmux is installed"
else
  echo "tmux is not install"
  sudo pacman -S tmux --noconfirm
fi

if pacman -Qi go >/dev/null 2>&1; then
  echo "go is installed"
else
  echo "go is not install"
  sudo pacman -S go --noconfirm
fi
sudo usermod -aG input $USER
cp -r config/hypr ${HOME}/.config/hypr
cp -r config/foot ${HOME}/.config/foot
if pacman -Qi wmenu >/dev/null 2>&1; then
  echo "wmenu is installed"
else
  echo "wmenu is not install"
  sudo pacman -S wmenu --noconfirm
fi
if [ -f /usr/share/fonts/TTF/BlexMonoNerdFontMono-Text.ttf ]; then
  echo "BlexMono Nerd Font is installed"
else
  echo "BlexMono Nerd Font is not install"
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/IBMPlexMono.zip
  unzip IBMPlexMono.zip -d IBMPlexMono
  sudo mv IBMPlexMono/*.ttf /usr/share/fonts/TTF
  fc-cache -fv
  rm -rf IBMPlexMono*
fi
if pacman -Qi dolphin >/dev/null 2>&1; then
  echo "dolphin is installed"
else
  echo "dolphin is not install"
  sudo pacman -S dolphin --noconfirm
fi
