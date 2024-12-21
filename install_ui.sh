#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

if command -v waybar >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}waybar is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}waybar is not installed${COLOR_NC}"
  sudo pacman -S waybar --noconfirm
fi

if command -v obsidian >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}bsidian is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}obsidian is not install${COLOR_NC}"
  sudo pacman -S obsidian --noconfirm
fi
if command -v google-chrome-stable >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}oogle-chrome-stable is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}google-chrome-stable is not install${COLOR_NC}"
  trizen -S google-chrome --noconfirm
fi

if command -v kate >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}kate is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}kate is not install${COLOR_NC}"
  sudo pacman -S kate --noconfirm
fi

if pacman -Qi otf-font-awesome >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}otf-font-awesome is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}otf-font-awesome is not install${COLOR_NC}"
  sudo pacman -S otf-font-awesome --noconfirm
fi
if pacman -Qi ttf-arimo-nerd >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}ttf-arimo-nerd is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}ttf-arimo-nerd is not install${COLOR_NC}"
  sudo pacman -S ttf-arimo-nerd --noconfirm
fi
if pacman -Qi noto-fonts >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}noto-fonts is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}noto-fonts is not install${COLOR_NC}"
  sudo pacman -S noto-fonts --noconfirm
fi

if pacman -Qi noto-fonts-cjk >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}noto-fonts-cjk is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}noto-fonts-cjk is not install${COLOR_NC}"
  sudo pacman -S noto-fonts-cjk --noconfirm
fi

if pacman -Qi noto-fonts-emoji >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}noto-fonts-emoji is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}noto-fonts-emoji is not install${COLOR_NC}"
  sudo pacman -S noto-fonts-emoji --noconfirm
fi

sudo usermod -aG input "$USER"
rm -rf $HOME/.config/hypr
ln -sf $HOME/dev/install-arch/config/hypr "${HOME}"/.config/hypr
rm -rf $HOME/.config/foot
ln -sf $HOME/dev/install-arch/config/foot "${HOME}"/.config/foot
rm -rf $HOME/.config/waybar
ln -sf $HOME/dev/install-arch/config/waybar $HOME/.config/waybar
if pacman -Qi wmenu >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}wmenu is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}wmenu is not install${COLOR_NC}"
  sudo pacman -S wmenu --noconfirm
fi
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
if pacman -Qi dolphin >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}dolphin is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}dolphin is not install${COLOR_NC}"
  sudo pacman -S dolphin --noconfirm
fi
if pacman -Qi xorg-xlsclients >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}xorg-xlsclients is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}xorg-xlsclients is not install${COLOR_NC}"
  sudo pacman -S xorg-xlsclients --noconfirm
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
if pacman -Qi flameshot-git >/dev/null 2>&1; then
  echo -e "${COLOR_GREEN}flameshot-git is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}flameshot-git is not install"
  trizen -S flameshot-git --noconfirm
fi

if pacman -Qi hyprland &>/dev/null; then
  echo -e "${COLOR_GREEN}hyprland is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}hyprland is not install"
  trizen -S hyprland --noconfirm
fi

if pacman -Qi greetd &>/dev/null; then
  echo -e "${COLOR_GREEN}greetd is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}greetd is not install"
  trizen -S greetd --noconfirm
fi
sudo systemctl enable greetd
sudo systemctl start greetd
sudo usermod -aG video greeter
if [ ! -e /etc/greetd/config.toml.ori ]; then
  sudo cp /etc/greetd/config.toml /etc/greetd/config.toml.ori
fi
sudo sed -i 's/^command.*/command = "Hyprland"/p' /etc/greetd/config.toml
sudo sed -i 's/^user.*/user = "pix"/p' /etc/greetd/config.toml

if pacman -Qi foot &>/dev/null; then
  echo -e "${COLOR_GREEN}foot is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}foot is not install"
  trizen -S foot --noconfirm
fi

if pacman -Qi wlogout &>/dev/null; then
  echo -e "${COLOR_GREEN}wlogout is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}wlogout is not install"
  trizen -S wlogout --noconfirm
fi

rm -rf $HOME/.config/fcitx5
ln -sf $HOME/dev/install-arch/config/fcitx5 $HOME/.config/fcitx5

if pacman -Qi xdg-desktop-portal-hyprland &>/dev/null; then
  echo -e "${COLOR_GREEN}xdg-desktop-portal-hyprland is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}xdg-desktop-portal-hyprland is not install"
  trizen -S xdg-desktop-portal-hyprland --noconfirm
fi

if pacman -Qi xorg-xrdb &>/dev/null; then
  echo -e "${COLOR_GREEN}xorg-xrdb is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}xorg-xrdb is not install"
  trizen -S xorg-xrdb --noconfirm
fi
