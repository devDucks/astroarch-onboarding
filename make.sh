cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DWITH_QT6=ON -DINSTALL_CONFIG=ON -DSKIP_MODULES="bootloader displaymanager dracut dracutlukscfg dummycpp dummyprocess dummypython fsresizer fstab grubcfg initcpio initcpiocfg initramfscfg luksbootkeyfile luksopenswaphookcfg mkinitfs mount networkcfg  openrcdmcryptcfg oemid partition plymouthcfg preservefiles rawfs removeuser services-openrc services-systemd tracking umount unpackfs users usersq zfs zfshostid" ..
make -j$(nproc)
sudo make install
