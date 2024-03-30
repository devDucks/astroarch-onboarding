export PATH=/usr/share/GSC/bin:$HOME/bin:/usr/local/bin:$PATH
export ZSH="$HOME/.oh-my-zsh"
export LC_CTYPE=en_US.UTF-8

ZSH_THEME="af-magic"

zstyle ':omz:update' mode disabled

ENABLE_CORRECTION="false"
HIST_STAMPS="yyyy-mm-dd"

plugins=(git archlinux)

source $ZSH/oh-my-zsh.sh

EDITOR=nano
INDI_ROLLBACK_VERSION=2.0.5-1
INDI_LIBS_ROLLBACK_VERSION=2.0.5-1
INDI_DRIVERS_ROLLBACK_VERSION=2.0.5-2
KSTARS_ROLLBACK_VERSION=3.6.8-2

# Alias section
alias update-astromonitor='wget -O - https://raw.githubusercontent.com/MattBlack85/astro_monitor/main/install.sh | sh'
alias astro-rollback-full='astro-rollback-indi && astro-rollback-kstars'

# Run aa_motd.sh
bash /home/astronaut/.astroarch/scripts/aa_motd.sh

function use-astro-bleeding-edge()
{
    sudo pacman -Sy && yes | LC_ALL=en_US.UTF-8 sudo pacman -S kstars-git libindi-git indi-3rdparty-drivers-git indi-3rdparty-libs-git
}

function use-astro-stable()
{
    sudo pacman -Sy && yes | LC_ALL=en_US.UTF-8 sudo pacman -S kstars libindi indi-3rdparty-drivers indi-3rdparty-libs
}


function astro-rollback-indi()
{
    setopt localoptions rmstarsilent
    mkdir -p ~/.rollback
    cd ~/.rollback
    wget -O indi-3rdparty-drivers-${INDI_DRIVERS_ROLLBACK_VERSION}-aarch64.pkg.tar.xz http://astromatto.com:9000/aarch64/indi-3rdparty-drivers-${INDI_DRIVERS_ROLLBACK_VERSION}-aarch64.pkg.tar.xz
    wget -O libindi-${INDI_ROLLBACK_VERSION}-aarch64.pkg.tar.xz http://astromatto.com:9000/aarch64/libindi-${INDI_ROLLBACK_VERSION}-aarch64.pkg.tar.xz
    wget -O indi-3rdparty-libs-${INDI_LIBS_ROLLBACK_VERSION}-aarch64.pkg.tar.xz http://astromatto.com:9000/aarch64/indi-3rdparty-libs-${INDI_LIBS_ROLLBACK_VERSION}-aarch64.pkg.tar.xz
    sudo pacman -U libindi* indi* --noconfirm
    cd - > /dev/null 2>&1
    rm -rf ~/.rollback/*
}

function astro-rollback-kstars()
{
    setopt localoptions rmstarsilent
    mkdir -p ~/.rollback
    cd ~/.rollback
    wget -O kstars-${KSTARS_ROLLBACK_VERSION}-aarch64.pkg.tar.xz http://astromatto.com:9000/aarch64/kstars-${KSTARS_ROLLBACK_VERSION}-aarch64.pkg.tar.xz
    sudo pacman -U kstars* --noconfirm
    cd - > /dev/null 2>&1
    rm -rf ~/.rollback/*
}

function update-astroarch()
{
    USER=astronaut

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
    yes | LC_ALL=en_US.UTF-8 sudo pacman -S archlinux-keyring

    # Now upgrade all system packages
    yes | LC_ALL=en_US.UTF-8 sudo pacman -Syu
}

function gps_on()
{
    # GPS copy gps config & configure chrony
    sudo rm -f /etc/default/gpsd
    sudo cp /home/astronaut/.astroarch/configs/gpsd /etc/default/gpsd
    sudo sed -i '$a refclock SHM 0 offset 0.5 delay 0.2 refid NMEA' /etc/chrony.conf
    sudo sed -i '$a driftfile /var/lib/chrony/drift' /etc/chrony.conf
    sudo systemctl enable gpsd.service
}

function gps_off()
{
    sudo systemctl stop gpsd.service
    sudo systemctl disable gpsd.service
    sudo sed -i '/refclock SHM 0 offset 0.5 delay 0.2 refid NMEA/d' /etc/chrony.conf
    sudo sed -i '/driftfile \/var\/lib\/chrony\/drift/d' /etc/chrony.conf
}

function ftp_on()
{
    yes | LC_ALL=en_US.UTF-8 sudo pacman -S vsftpd
    sudo rm  /etc/vsftpd.conf
    sudo cp /home/astronaut/.astroarch/configs/vsftpd.conf  /etc/
    sudo cp /home/astronaut/.astroarch/configs/vsftpd.chroot_list /etc/
    sudo systemctl enable vsftpd.service
}

function ftp_off()
{
    sudo systemctl stop vsftpd.service
    sudo systemctl disable vsftpd.service
    sudo rm -f /etc/vsftpd.conf
    sudo rm -f  /etc/vsftpd.chroot_list
}

function bluetooth_on()
{
    yes | LC_ALL=en_US.UTF-8 sudo pacman -S bluez bluez-utils bluez-hid2hci bluedevil
    # Bluetooch config
    sudo sed -i 's/#DiscoverableTimeout=0/DiscoverableTimeout=0/g' /etc/bluetooth/main.conf
    sudo sed -i 's/#AlwaysPairable=true/AlwaysPairable=true/g' /etc/bluetooth/main.conf
    sudo sed -i 's/#PairableTimeout=0/PairableTimeout=0/g' /etc/bluetooth/main.conf
    sudo sed -i 's/#AutoEnable=true/AutoEnable=true/g' /etc/bluetooth/main.conf
    sudo systemctl enable bluetooth.service
}

function bluetooth_off()
{
    sudo systemctl stop bluetooth.service
    sudo systemctl disable bluetooth.service
    sudo sed -i 's/DiscoverableTimeout=0/#DiscoverableTimeout=0/g' /etc/bluetooth/main.conf
    sudo sed -i 's/AlwaysPairable=true/#AlwaysPairable=true/g' /etc/bluetooth/main.conf
    sudo sed -i 's/PairableTimeout=0/#PairableTimeout=0/g' /etc/bluetooth/main.conf
    sudo sed -i 's/AutoEnable=true/#AutoEnable=true/g' /etc/bluetooth/main.conf
}
