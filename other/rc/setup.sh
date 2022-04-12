#!/bin/bash

CUR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sf $CUR/bashrc ~/.bashrc
ln -sf $CUR/xinitrc ~/.xinitrc
ln -sf $CUR/vimrc ~/.vimrc
