#!/bin/bash

# Beginning
clear
echo 
echo ====================
echo Beginning the process
echo ====================

# adding pause between commands
# trap "set +x; sleep 5; set -x" DEBUG
set -x  # show command
 
trap read debug  # require a RETURN after each command executed


# Packages to Install
echo Setting Packages to be installed 
developers='git vim terminator htop p7zip* unrar curl zsh zeal insomnia httpie'
virtualbox='virtualbox virtualbox-guest-additions-iso'
office='libreoffice'
python='python3-pip'
python_pip='docker-compose flake8 ipython isort jupyter jupyterlab pipenv pylint requests'
network='ssh remmina'
internet='google-chrome-stable browsh'
video='vlc'
apps='calibre ranger sxiv hexchat'
vscode='apt-transport-https code'
i3='i3, i3-wm i3blocks i3lock i3status'
docker='docker-ce apt-transport-https ca-certificates software-properties-common'

# Cloning my repositories
mkdir GITHUB
cd GITHUB
curl -s https://api.github.com/users/toguko/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone

echo Setting up Repositories
echo DOCKER
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable

echo Google
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# adding Vscode
echo Vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" >$

echo Insomnia API Client
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
# Add public key used to verify code signature
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -

# Installing Oh-my-zsh
# https://gist.github.com/renshuki/3cf3de6e7f00fa7e744a
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.s$

# Configuring .zshrc
# Install powerline font and fontawesome
echo Installing Powerline
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
mkdir -p .config/fontconfig/conf.d #if directory doesn't exists
fc-cache -vf ~/.fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

echo Installing Fontawesome
wget -c https://github.com/FortAwesome/Font-Awesome/blob/master/fonts/fontawesome-webfont.ttf
sudo mkdir -p /usr/local/share/fonts
cd Downloads/
ls
sudo mv fontawesome-webfont.ttf /usr/local/share/fonts/
sudo mv fa-regular-400.ttf /usr/local/share/fonts/
sudo fc-cache -v

echo Setting zsh Syntax Highlighting
# https://dev.to/mskian/install-z-shell-oh-my-zsh-on-ubuntu-1804-lts-4cm4
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlig$
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"

# Copying my rc from github

echo Updating system
# Basic update
sudo apt-get -y --force-yes update
sudo apt-get -y --force-yes upgrade

echo Installing all Packages
#Instaling packages

sudo apt-get -y --force-yes install $developers
sudo apt-get -y --force-yes install $virtualbox
sudo apt-get -y --force-yes install $office
sudo apt-get -y --force-yes install $python
sudo apt-get -y --force-yes install $network
sudo apt-get -y --force-yes install $internet
sudo apt-get -y --force-yes install $video
sudo apt-get -y --force-yes install $apps
sudo apt-get -y --force-yes install $vscode
sudo apt-get -y --force-yes install $i3
sudo apt-get -y --force-yes install $docker
pip install --upgrade pip
echo Instaling pip packages
sudo -H pip install virtualenv

echo Download and Setting Dropbox
# Dropbox
cd ~ && wget -O dropbox "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf
wget -O ~/dropbox.py "https://raw.githubusercontent.com/toguko/my_rc_files/master/dropbox.py"
python ~/dropbox.py start -i
python ~/dropbox.py autostart -y

# Dotfiles section
# This section is dedicated to the dot files (.bash, .vimrc...) installed in your home folder.
# Adicionar aqui minha configuracao do vim no github igual o acima
# I3 Config
#wget -P ~/.config/.i3/
# ZSH Config
#wget -P ~/
# Terminator Config
curl -o ~/.config/terminator/config --create-dirs https://raw.githubusercontent.com/toguko/my_rc_fi      les/master/.config/terminator/config

echo Clean everything
# Clean everything
sudo apt-get -y --force-yes autoremove && sudo apt-get clean

# Prompt for a reboot
echo  ALL FINISHED
