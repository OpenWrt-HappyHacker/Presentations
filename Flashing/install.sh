#!/bin/sh
#
# How to flash your OpenWrt image to the ZSUN device:
#
# 1) Copy the following files to the SD card:
#    install.sh      (this script)
#    openwrt-ar71xx-generic-zsun-sdreader-kernel.bin
#    openwrt-ar71xx-generic-zsun-sdreader-rootfs-squashfs.bin
#
# 2) Use the ZSUN mobile app to switch to "Wireless shared drive" mode.
#    If plugged to a PC make sure to unmount the drive first.
#
# 3) Join the wireless AP created by the ZSUN device
#    (begins with "zd-" followed by a number)
#
# 4) Log in to the device using its practical firmware backdoor ;)
#    $ telnet 10.168.168.1 11880
#    Username: root
#    Password: zsun1188
#
# 5) Run the following command:
#    $ sh /etc/disk/install.sh
#
# 6) DO NOT UNPLUG THE DEVICE WHILE FLASHING
#    Wait until it's done, you should get a "Bus error" message (this is fine)
#
# 7) When the shell prompt returns, Do absolutely nothing else with the ZSUN device,
#    just immediately unplug it. Wait a few seconds and plug it again.
#
# 8) You should now have a fully working OpenWrt build.
#    Be aware OpenWrt is much slower to boot than the original firmware,
#    so if it seems to take a while to start up don't panic ;)
#
# Enjoy! :)
#

if [ "$0" = "/etc/disk/install.sh" ]
then

    if ! [ -f /etc/disk/openwrt-ar71xx-generic-zsun-sdreader-kernel.bin ]
    then
        echo "Error: OpenWrt kernel not found"
        exit 1
    fi
    if ! [ -f /etc/disk/openwrt-ar71xx-generic-zsun-sdreader-rootfs-squashfs.bin ]
    then
        echo "Error: OpenWrt rootfs not found"
        exit 1
    fi
    if ! grep -F mtd2 /proc/mtd | grep -Fq rootfs
    then
        echo "Error: MTD2 (rootfs) not found"
        exit 1
    fi
    if ! grep -F mtd3 /proc/mtd | grep -Fq uImage
    then
        echo "Error: MTD3 (uImage) not found"
        exit 1
    fi

    echo "Preparing filesystem..."
    cp /etc/disk/install.sh /tmp/
    sh /tmp/install.sh
    # continues below...

elif [ "$0" = "/tmp/install.sh" ]
then
    
    # ...comes from above
    cp -Ppr /bin /tmp/
    mount -o bind /tmp/bin /bin

    echo "Reading files from SD card..."
    cp /etc/disk/openwrt-ar71xx-generic-zsun-sdreader-kernel.bin /tmp/
    cp /etc/disk/openwrt-ar71xx-generic-zsun-sdreader-rootfs-squashfs.bin /tmp/

    echo "Killing daemons..."
    for d in php-cgi smbd nmbd udhcpd webs clearlog dnsserver lighttpd boa tfcheck wifi_daemon upsamb daemon
    do
        killall $d 2> /dev/null
    done

    echo "Writing kernel image..."
    if mtd_write write /tmp/openwrt-ar71xx-generic-zsun-sdreader-kernel.bin /dev/mtd3 | grep -Fq "Bus error"
    then
        echo "Error: there was a problem writing kernel image :("
    fi

    echo "Writing root filesystem..."
    if mtd_write write /tmp/openwrt-ar71xx-generic-zsun-sdreader-rootfs-squashfs.bin /dev/mtd2 | grep -Fq "Bus error"
    then
        echo "Error: there was a problem writing root filesystem :("
    fi

    echo "Finished"

else
    echo "Error: Must run from /etc/disk/install.sh"
fi

