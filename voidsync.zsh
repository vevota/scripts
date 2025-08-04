#!/bin/zsh

# update xbps
echo "Running xbps-install -Su"
doas xbps-install -Su

#pulls and updates void-src
echo "Updating void-src"
cd void-packages/
git pull

# install updated packages
doas xbps-install -u

# update flatpak
echo "Updating Flatpak"
flatpak update -y


