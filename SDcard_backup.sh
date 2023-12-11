#!/bin/bash

# One command to rule them all! The fastest way to backup the SD card on your Pi
# is to make a direct copy from the running SD card onto a second SD card that
# has been connected via USB.
# Best of all, you do it all from the Pi itself!
# No need for another host or shutting down your Pi or transferring files.
#
# Make sure you remove ALL existing USB drives you may have connected before proceeding!
#
# For best results a usb sd card adaptor is ideal - ready to swap when the worst happens
#
# Robin M0JQQ October 2023 **Any snags; please let me know. Thanks!
clear
echo " ";echo " "
echo " ";echo " "
echo "     RPi SD Card backup for USB drive or USB SD card adaptor"
echo "     PLEASE REMOVE ALL USB DRIVES BEFORE PROCEEDING"
echo " ";echo " "
read -rsn1 -p"     Checking no USB drives attached - Press any key when ready"
#echo" "
while ls /dev/sda*|grep 'sda' ; do
echo "     Please rmove all USB drives"
sleep 2
done
echo "     No USB drives found"
sleep 1
echo " ";echo " "
read -rsn1 -p"     Please insert USB/SD drive and press any key when ready";echo""
while !(ls /dev/sda*|grep 'sda') ; do
echo "     Please insert your USB drive"
sleep 2
done
echo " ";echo " "
read -rsn1 -p"     Backup drive inserted - hit any key when ready";echo""
echo "        WARNING - This will take about 30 minutes for a 32G card";echo""
# Stop all services
sudo systemctl stop linbpq
echo "         LINBPQ STOPPED"


now=$(date +"%T")
echo "     Backup commenced at: $now"
sudo dd bs=4M if=/dev/mmcblk0 of=/dev/sda
sleep 2
now=$(date +"%T")
echo "     Backup complete.. Time: $now"
echo" ";echo" "
echo "     Now test your backup!"
sudo systemctl start linbpq
echo "     LINBPQ STARTED"
exit