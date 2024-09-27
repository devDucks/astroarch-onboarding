#!/bin/sh

# Add folders to .astroarch
cp -R "/usr/share/calamares/.astroarch/configs/calamares_astroarch" "/home/astronaut/.astroarch/configs/"
cp -R "/usr/share/calamares/.astroarch/plugins/power_max_current" "/home/astronaut/.astroarch/plugins/"

# Link folders to root folder
rm -f /root/.oh-my-zsh
ln -s /home/astronaut/.oh-my-zsh /root
rm -f /root/.astroarch
ln -s /home/astronaut/.astroarch /root
rm -f /root/.zshrc
ln -s /home/astronaut/.astroarch/configs/.zshrc /root/.zshrc
chsh -s /usr/bin/zsh root

# link to folder autostart
ln -s /usr/share/calamares/.astroarch/configs/calamares_astroarch/AstroArch-onboarding.desktop /home/astronaut/.config/autostart/AstroArch-onboarding.desktop
