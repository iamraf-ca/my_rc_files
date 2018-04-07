#!/bin/bash
export COLOR="\[\033[0;32m\]"

cd /Downloads

# Add to sources
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
# Add public key used to verify code signature
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -

sudo add-apt-repository ppa:webupd8team/java

#echo -e "${COLOR}Remove packages"; tput sgr0
sudo apt -y purge vim-tiny
sudo apt -y autoremove

echo -e "${COLOR}Upgrade system"; tput sgr0
sudo apt -y update
sudo apt -y dist-upgrade
sudo apt -y gcc make perl

echo -e "${COLOR}Download and install Google Chrome"; tput sgr0
wget -c https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install VirtualBox"; tput sgr0
wget -c https://download.virtualbox.org/virtualbox/5.2.8/virtualbox-5.2_5.2.8-121009~Ubuntu~xenial_amd64.deb
sudo dpkg -i virtualbox-5.2_5.2.8-121009~Ubuntu~xenial_amd64.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install Zoom"; tput sgr0
wget -c https://zoom.us/client/latest/zoom_amd64.deb
sudo dpkg -i zoom_amd64.deb
sudo apt -y install -f

echo -e "${COLOR}Download and install VLC"; tput sgr0
sudo apt -y vlc

echo -e "${COLOR}Installing Calibre"; tput sgr0
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | sudo python -c "import sys; main=lambda:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main()"

echo -e "${COLOR}Install packages"; tput sgr0
sudo apt -y install kubuntu-restricted-addons kubuntu-restricted-extras kubuntu-driver-manager partitionmanager kcalc libreoffice kdenlive smb4k amarok msttcorefonts samba
sudo apt -y install p7zip-full qbittorrent audacity screenfetch unrar pinta

echo -e "${COLOR}Install dev tools"; tput sgr0
sudo apt -y install git curl httpie imagemagick zeal terminator zsh python-pip virtualenv python3-pip python3-venv python-dev build-essential vim direnv docker docker-compose libncurses5-dev default-jre default-jdk oracle-java9-installer binutils libproj-dev gdal-bin

echo -e "${COLOR}Install oh-my-zsh now"; tput sgr0
cd
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s `which zsh`
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
mkdir ~/.config/fontconfig/conf.d/
fc-cache -vf ~/.fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
vim ~/.zshrc


git clone git://github.com/sigurdga/gnome-terminal-colors-solarized.git ~/.solarized
cd ~/.solarized
./install.sh
cd ~/Downloads

echo -e "${COLOR}Clear system cache"; tput sgr0
rm -rf ~/.cache/plasm* ~/.cache/ico*
sudo apt -y clean

echo -e "${COLOR}Installing Skype"; tput sgr0
wget https://repo.skype.com/latest/skypeforlinux-64.deb
sudo dpkg -i skypeforlinux-64.deb

# Refresh repository sources and install Insomnia
sudo apt-get install insomnia

kdialog --passivepopup "Kubuntu After Install Finished!" --icon "kde" 10
