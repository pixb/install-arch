#!/bin/bash
sed -i '/Server/s/^#//p' /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist | grep ustc >> ustc.txt
sed '5r ustc.txt' /etc/pacman.d/mirrorlist > temp.txt && mv temp.txt /etc/pacman.d/mirrorlist
rm ustc.txt
pacman -Syyu
pacman-key --init
pacman-key --populate archlinux

pacman -Syyu vi zsh sudo
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^# //p' /etc/sudoers
useradd --create-home --groups wheel,root --shell /bin/zsh pix

# set default user
cat <<EOF> /etc/wsl.conf
[user]
default = pix
EOF
