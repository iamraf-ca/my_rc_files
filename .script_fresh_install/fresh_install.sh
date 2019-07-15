#!/bin/bash

# Beginning
clear
echo 
echo ====================
echo Beginning the process
echo ====================

# adding pause between commands
# trap "set +x; sleep 5; set -x" DEBUG
#set -x  # show command
#trap read debug  # require a RETURN after each command executed

# Packages to Install
echo Setting Packages to be installed 
developers='git vim terminator htop p7zip* unrar curl zsh zeal insomnia httpie'
virtualbox='virtualbox-6.0 virtualbox-guest-additions-iso'
python='python3-pip'
#python_pip='docker-compose flake8 ipython isort jupyter jupyterlab pipenv pylint requests'
network='ssh remmina'
internet='google-chrome-stable lynx'
video='vlc'
apps='calibre ranger sxiv hexchat'
vscode='apt-transport-https code'
i3='i3 i3-wm i3blocks i3lock i3status powerline fonts-powerline zsh-theme-powerlevel9k zsh-syntax-highlighting'
docker='docker-ce apt-transport-https ca-certificates software-properties-common gnupg-agent'

# Cloning my repositories
mkdir GITHUB
cd GITHUB
curl -s https://api.github.com/users/toguko/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone
cd ~/

echo Setting up Repositories
echo Setting DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge test"

echo Setting Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

# adding Vscode
echo Setting Visual Studio Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

# adding Virtualbox 6
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb http://download.virtualbox.org/virtualbox/debian bionic contrib"

echo Setting Insomnia API Client
echo "deb https://dl.bintray.com/getinsomnia/Insomnia /" \
    | sudo tee -a /etc/apt/sources.list.d/insomnia.list
# Add public key used to verify code signature
wget --quiet -O - https://insomnia.rest/keys/debian-public.key.asc \
    | sudo apt-key add -

echo Updating system
# Basic update
sudo apt-get -y update
sudo apt-get -y upgrade

echo Installing all Packages
sudo apt-get install -y $developers
sudo apt-get install -y $virtualbox
sudo apt-get install -y $office
sudo apt-get install -y $python
sudo apt-get install -y $network
sudo apt-get install -y $internet
sudo apt-get install -y $video
sudo apt-get install -y $apps
sudo apt-get install -y $vscode
sudo apt-get install -y $i3
sudo apt-get install -y $docker
sudo -H pip3 install --upgrade pip
#echo Instaling pip packages
sudo -H pip3 install virtualenv

# Installing Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
chsh -s /bin/zsh
sudo usermod -s /usr/bin/zsh $(whoami)

#echo Download and Setting Dropbox
# Dropbox
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#~/.dropbox-dist/dropboxd

# Dotfiles section
# This section is dedicated to the dot files (.bash, .vimrc...) installed in your home folder.
# Adicionar aqui minha configuracao do vim no github igual o acima
echo Copying I3WM Config
curl -o ~/.config/i3/config --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.config/i3/config
curl -o ~/.config/i3/i3blocks/i3blocks.conf --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.config/i3/i3blocks/i3blocks.conf


echo Copying ZSH Config
curl -o ~/.zshrc --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.zshrc

echo Copying Terminator Config
curl -o ~/.config/terminator/config --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.config/terminator/config

echo Copying VIM Config
curl -o ~/.vimrc --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

echo Add your user account to the docker group
sudo usermod -aG docker $USER

echo Clean everything
# Clean everything
sudo apt-get -y autoremove && sudo apt-get clean

echo ====================
echo  ALL FINISHED
echo ====================
