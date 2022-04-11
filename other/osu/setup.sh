#!/bin/bash

# stackoverflow.com/questions/59895
OSU=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ln -sf $OSU/yorokobe_skin.ini.wal $HOME/.config/wal/templates/yorokobe_skin.ini

echo "[osu] Make sure to ln -s \
$HOME/.cache/wal/yorokobe_skin.ini to your osu skin"
