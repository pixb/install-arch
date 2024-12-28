#!/bin/bash
sed -i '/Server/s/^#//p' /etc/pacman.d/mirrorlist
cat /etc/pacman.d/mirrorlist | grep ustc >> ustc.txt
sed '5r ustc.txt' /etc/pacman.d/mirrorlist > temp.txt && mv temp.txt /etc/pacman.d/mirrorlist
rm ustc.txt
# pacman -Sy archlinux-keyring
# pacman-key --refresh-keys
pacman -Syyu --noconfirm
pacman-key --init
pacman-key --populate archlinux

pacman -S vi zsh sudo --noconfirm
sed -i '/%wheel ALL=(ALL:ALL) ALL/s/^# //p' /etc/sudoers
useradd --create-home --groups wheel,root --shell /bin/zsh pix
passwd pix

# set default user
cat <<EOF> /etc/wsl.conf
[user]
default = pix
EOF
