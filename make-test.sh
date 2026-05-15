#!/usr/bin/env bash

# Before install packages ckbcomp cmake yaml-cpp extra-cmake-modules
check_ckbcomp=$(pacman -Q | grep -c ckbcomp)
if [ $check_ckbcomp -eq 0 ]; then
    echo "ckbcomp not found... Installing"
    sudo pacman -Sy ckbcomp --noconfirm
    echo "ckbcomp installed"
fi
check_cmake=$(pacman -Q | grep -c cmake)
if [ $check_cmake -eq 0 ]; then
    echo "cmake not found... Installing"
    sudo pacman -Sy cmake --noconfirm
    echo "cmake installed"
fi
check_yamlcpp=$(pacman -Q | grep -c yaml-cpp)
if [ $check_yamlcpp -eq 0 ]; then
    echo "yaml-cpp not found... Installing"
    sudo pacman -Sy yaml-cpp --noconfirm
    echo "yaml-cpp installed"
fi
check_extracmakemodules=$(pacman -Q | grep -c extra-cmake-modules)
if [ $check_extracmakemodules -eq 0 ]; then
    echo "extra-cmake-modules not found... Installing"
    sudo pacman -Sy extra-cmake-modules --noconfirm
    echo "extra-cmake-modules installed"
fi

check_base_devel=$(pacman -Q | grep -c base-devel)
if [ $check_base_devel -eq 0 ]; then
    echo "base-devel not found... Installing"
    sudo pacman -Sy base-devel --noconfirm
    echo "base-devel installed"
fi

check_make=$(pacman -Q | grep -c make)
if [ $check_make -eq 0 ]; then
    echo "make not found... Installing"
    sudo pacman -Sy make --noconfirm
    echo "make installed"
fi

# Build
mkdir -p build
cd build
cmake -DCMAKE_BUILD_TYPE=release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DWITH_QT6=ON -DINSTALL_CONFIG=ON ..
make -j$(nproc)
# Install
sudo make install

# Temporarily allow the root user to access the local user's X session
#xhost +si:localuser:root

cd ..
# Install files
sudo mkdir -p /usr/share/calamares/branding
sudo cp -R ./src/branding/astroarch /usr/share/calamares/branding/
sudo cp ./src/usr/share/astroarch_onboarding/configs/49-nopasswd-calamares-vnc.rules /etc/polkit-1/rules.d/49-nopasswd-calamares-vnc.rules
sudo cp ./src/usr/share/astroarch_onboarding/configs/49-nopasswd-calamares-xrdp.rules /etc/polkit-1/rules.d/49-nopasswd-calamares-xrdp.rules
sudo cp ./src/usr/share/astroarch_onboarding/configs/com.github.calamares.calamares.policy /usr/share/polkit-1/actions/com.github.calamares.calamares.policy
sudo cp -r ./src/usr/share/astroarch_onboarding /usr/share/

