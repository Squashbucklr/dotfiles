#!/bin/bash

CUR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "[grub] sudo required to write to /etc/default/grub"

sed s~{CUR}~$CUR~ $CUR/grub.template | sudo tee /etc/default/grub > /dev/null

echo "[grub] make sure to run grub-mkconfig -o /boot/grub/grub.cfg"
