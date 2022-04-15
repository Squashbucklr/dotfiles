#!/bin/bash

echo "[grub] sudo required to write to /etc/default/grub"

cat $HOME/.config/grub/grub | sudo tee /etc/default/grub > /dev/null

echo "[grub] make sure to run grub-mkconfig -o /boot/grub/grub.cfg"
