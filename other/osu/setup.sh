#!/bin/bash

CUR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sf $CUR/yorokobe_skin.ini.wal $HOME/.config/wal/templates/yorokobe_skin.ini

echo "[osu] Make sure to ln -s \
$HOME/.cache/wal/yorokobe_skin.ini to your osu skin"
