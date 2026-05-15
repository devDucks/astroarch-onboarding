#!/usr/bin/env bash

# Remove files and folders
sudo rm /etc/polkit-1/rules.d/49-nopasswd-calamares-vnc.rules
sudo rm /etc/polkit-1/rules.d/49-nopasswd-calamares-xrdp.rules
sudo rm /usr/share/polkit-1/actions/com.github.calamares.calamares.policy
sudo rm /usr/share/astroarch_onboarding
rm -rf /home/astronaut/.astroarch/plugins/power_max_current
sudo rm -rf /usr/share/calamares
sudo rm /usr/lib/calamares/libcalamares.so
sudo rm /usr/lib/libcalamares.so
sudo rm /usr/lib/libcalamaresui.so

# Uninstall
cd build
sudo make uninstall
cd ..

