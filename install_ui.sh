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

pacman_install waybar
pacman_install obsidian
trizen_install google-chrome
pacman_install kate
pacman_install otf-font-awesome
pacman_install ttf-arimo-nerd
pacman_install noto-fonts
pacman_install noto-fonts-cjk
pacman_install noto-fonts-emoji

sudo usermod -aG input "$USER"
rm -rf "$HOME/.config/hypr"
ln -sf "$HOME/dev/install-arch/config/hypr" "${HOME}/.config/hypr"
rm -rf "$HOME/.config/sway"
ln -sf "$HOME/dev/install-arch/config/sway" "${HOME}/.config/sway"
rm -rf "$HOME/.config/foot"
ln -sf "$HOME/dev/install-arch/config/foot" "${HOME}/.config/foot"
rm -rf "$HOME/.config/waybar"
ln -sf "$HOME/dev/install-arch/config/waybar" "$HOME/.config/waybar"

pacman_install wmenu

if [ -f /usr/share/fonts/OTF/MonaspiceArNerdFont-Bold.otf ]; then
  echo -e "${COLOR_GREEN}Monaspice  Nerd Font is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}Monaspice Nerd Font is not install${COLOR_NC}"
  if [ -f ./res/Monaspace.zip ]; then
    echo -e "${COLOR_GREEN}./res/Monaspace.zip is exists${COLOR_GREEN}"
  else
    if [ ! -e ./res ]; then
      mkdir -p res
    fi
    echo -e "${COLOR_YELLOW}./res/Monaspace.zip is not exists,download...${COLOR_NC}"
    wget -O ./res/Monaspace.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Monaspace.zip
  fi
  if [ -f ./res/Monaspace.zip ]; then
    unzip ./res/Monaspace.zip -d ./res/Monaspace
    sudo mv ./res/Monaspace/*.otf /usr/share/fonts/OTF
    sudo mv ./res/Monaspace/*.ttf /usr/share/fonts/TTF
    fc-cache -fv
  fi
fi
pacman_install dolphin
pacman_install xorg-xlsclients
pacman_install fcitx5
pacman_install fcitx5-chinese-addons
pacman_install fcitx5-configtool
pacman_install fcitx5-gtk
pacman_install fcitx5-qt
trizen_install fcitx5-skin-fluentdark-git
trizen_install adwaita-qt5
trizen_install adwaita-qt6
pacman_install grim
pacman_install code
trizen_install flameshot-git

trizen_install hyprland
pacman_install sway
pacman_install swaybg
trizen_install greetd

sudo systemctl enable greetd
sudo systemctl start greetd
sudo usermod -aG video greeter
if [ ! -e /etc/greetd/config.toml.ori ]; then
  sudo cp /etc/greetd/config.toml /etc/greetd/config.toml.ori
fi
sudo sed -i 's/^command.*/command = "Hyprland"/' /etc/greetd/config.toml
sudo sed -i 's/^user.*/user = "pix"/' /etc/greetd/config.toml

trizen_install foot
trizen_install wlogout

rm -rf "$HOME/.config/fcitx5"
ln -sf "$HOME/dev/install-arch/config/fcitx5" "$HOME/.config/fcitx5"

trizen_install xdg-desktop-portal-hyprland
trizen_install xorg-xrdb
trizen_install hyprland-qtutils
pacman_install cliphist
pacman_install wl-clipboard
pacman_install i3status
ln -sf "$HOME/dev/install-arch/config/i3status" "$HOME/.config/i3status"
