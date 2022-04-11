#!/bin/bash

if [[ ! -f $HOME/.config/mpv/scripts/bookmarker-menu.lua ]]; then
    echo "[mpv] warning: missing bookmarker-menu.lua"
fi
if [[ ! -f $HOME/.config/mpv/scripts/copy-subtitle.lua ]]; then
    echo "[mpv] warning: missing copy-subtitle.lua"
fi
if [[ ! -f $HOME/.config/mpv/scripts/downmix.lua ]]; then
    echo "[mpv] warning: missing downmix.lua"
fi
if [[ ! -f $HOME/.config/mpv/scripts/seek-to.lua ]]; then
    echo "[mpv] warning: missing seek-to.lua"
fi
