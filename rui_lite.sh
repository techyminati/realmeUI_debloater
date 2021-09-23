#!/bin/bash
# SPDX-License-Identifier: GPL-3.0-or-later
# (c) TechyMinati ( Aryan Sinha ) <sinha.aryan03@gmail.com>
# Usage: ./rui_lite.sh <Direct Link to realmeUi 2.0 full OTA> <Device Name>
# Note: This only works with realmeUI 2.0 Stock ROM OTAs
# Thanks to Zidane for initial Patching idea

LINK=$1
DEVICE=$2

echo "========================================"
echo " Downloading realmeUI 2.0 Stock Package "
echo "========================================"

wget $LINK 

echo "========================================"
echo " ROM Downloaded Sucessfully ........... "
echo "========================================"

echo " Cloning Tools .... "
git clone https://github.com/sinhaaryan03/oppo_ozip_decrypt # oppo ozip decrypter
echo " Setting up ozip decryption dependencies "
sudo pip3 install -r oppo_ozip_decrypt/requirements.txt
echo " Starting Patching ... "
cd oppo_ozip_decrypt && ./ozipdecrypt.py ../*.ozip   # decrypt the ozip
echo " Nuking oplus Bloats"
cd out && rm -rf *my_preload* *my_region*  # These dynamic partitions are unnecesarry & all it has are oplus bloats
echo " Creating flashable zip "
zip -r9 realmeUI-Debloated-$DEVICE-$(env TZ='Asia/Kolkata' date +%Y%m%d).zip *
echo "========================================"
echo "    Patching Completed Sucessfully !    " 
echo "========================================"

