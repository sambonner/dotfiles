#!/bin/bash

echo "SYSRESOURCES=/etc/X11/Xresources" >> ~/.xprofile
echo "USRRESOURCES=$HOME/.Xresources" >> ~/.xprofile
xrdb -merge ~/.Xresources
