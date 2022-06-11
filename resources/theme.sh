#!/bin/bash

file=$1
back=$2
backend=()

if [[ -z $back ]]; then
    echo Parsing backend from filename
    echo $1 | grep "_colorthief" > /dev/null
    if [[ $? -eq 0 ]]; then
        echo Using backend colorthief
        backend=(--backend colorthief)
    fi

    echo $1 | grep "_colorz" > /dev/null
    if [[ $? -eq 0 ]]; then
        echo Using backend colorz
        backend=(--backend colorz)
    fi

    echo $1 | grep "_haishoku" > /dev/null
    if [[ $? -eq 0 ]]; then
        echo Using backend haishoku
        backend=(--backend haishoku)
    fi

    echo $1 | grep "_wal" > /dev/null
    if [[ $? -eq 0 ]]; then
        echo Using backend wal
        backend=(--backend wal)
    fi
else
    backend=(--backend $back)
fi

if [[ -z $file ]]; then
    wal -R
else
    wal -i $1 ${backend[@]}
fi

pywalfox update
pywal-discord
killall dunst
