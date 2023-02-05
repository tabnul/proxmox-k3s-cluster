#!/bin/bash
echo -e "n\np\n\n\n\nw\n" |fdisk /dev/sdb
mkfs -t ext4 /dev/sdb1
mkdir /mnt/longhorn
echo -e "/dev/sdb1 /mnt/longhorn ext4 defaults 0 2\n" >>/etc/fstab
mount -av