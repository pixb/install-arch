#!/bin/env bash
COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_YELLOW='\033[0;33m'
COLOR_NC='\033[0m'

# Monaspice NerdFont
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
  fi
fi

# NotoSansMNerdFont
if [ -f /usr/share/fonts/TTF/NotoSansMNerdFontMono-Regular.ttf ]; then
  echo -e "${COLOR_GREEN}NotoSansM  Nerd Font is installed${COLOR_NC}"
else
  echo -e "${COLOR_YELLOW}NotoSansM Nerd Font is not install${COLOR_NC}"
  if [ -f ./res/Noto.zip ]; then
    echo -e "${COLOR_GREEN}./res/Noto.zip is exists${COLOR_GREEN}"
  else
    if [ ! -e ./res ]; then
      mkdir -p res
    fi
    echo -e "${COLOR_YELLOW}./res/Noto.zip is not exists, download...${COLOR_NC}"
    wget -O ./res/Noto.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/Noto.zip
  fi
  if [ -f ./res/Noto.zip ]; then
    unzip ./res/Noto.zip -d ./res/Noto
    sudo mv ./res/Noto/*.otf /usr/share/fonts/OTF
    sudo mv ./res/Noto/*.ttf /usr/share/fonts/TTF
  fi
fi
fc-cache -fv
