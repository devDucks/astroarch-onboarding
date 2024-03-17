#!/bin/zsh

 # Store actual version
    OLD_VER=$(cat /home/$USER/.astroarch.version)

    # Checkout latest changes from git
    cd /home/$USER/.astroarch
    git pull origin main
    cd - > /dev/null 2>&1

    NEW_VER=$(cat /home/$USER/.astroarch/configs/.astroarch.version)

    if [ $OLD_VER != $NEW_VER ]; then
	zsh /home/$USER/.astroarch/scripts/$NEW_VER.sh
    fi;

    # Update always keyring first, than all of the other packages
    sudo pacman -Sy
    sudo pacman -S archlinux-keyring --noconfirm

    # Now upgrade all system packages
    sudo pacman -Syu --noconfirm
