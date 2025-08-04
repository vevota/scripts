#!/bin/zsh

# update xbps
echo "Running xbps-install -Su"
sudo xbps-install -Su

#pulls and updates void-src
echo "Updating void-src"
cd void-packages/
git checkout master
git pull upstream master

# install updated packages
sudo xbps-install -u

# update flatpak
echo "Updating Flatpak"
flatpak update -y

echo pogger

