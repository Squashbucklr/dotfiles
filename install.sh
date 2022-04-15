#!/bin/bash

#############################
echo "Installing dotfiles..."
#############################

DOTS=$( cd -- "$( dirname -- "${BASH_SOURCE[1]}" )" &> /dev/null && pwd )

###############################################
echo -e "\nInstalling ~/.config configurations"
###############################################

# create directories first
for config in $(ls $DOTS/config); do
    mkdir -pv $HOME/.config/$config
done

# run pre-link setup
for config in $(ls $DOTS/config); do
    if [[ -f $DOTS/config/$config/presetup.sh ]]; then
        $DOTS/config/$config/presetup.sh
    fi
done

# link files
for config in $(ls $DOTS/config); do
    # link all files
    for file in $(ls $DOTS/config/$config); do
        ln -sf $DOTS/config/$config/$file $HOME/.config/$config/$file
    done

    # link all wal files correctly
    for file in $(find $HOME/.config/$config -name "*.wal"); do
        template=$(basename ${file%%.wal})
        ln -sf $file $HOME/.config/wal/templates/$template
        p=$HOME/.config/$config/
        plen=${#p}
        pname=${file:plen}
        output=${pname%%.wal}
        ln -sf $HOME/.cache/wal/$template $HOME/.config/$config/$output
    done
done

# run post-link setup
for config in $(ls $DOTS/config); do
    if [[ -f $DOTS/config/$config/setup.sh ]]; then
        $DOTS/config/$config/setup.sh
    fi
done

################################################
echo -e "\nInstalling other user configurations"
################################################

for other in $(ls $DOTS/other); do
    if [[ -f $DOTS/other/$other/setup.sh ]]; then
        $DOTS/other/$other/setup.sh
    fi
done

#################
echo -e "\nDone."
#################

echo "[DOTS] you may need to run wal for some configurations to work"
