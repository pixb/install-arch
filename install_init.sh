pacstrap -i /mnt/ base linux linux-firmware
genfstab -U /mnt >>/mnt/etc/fstab
