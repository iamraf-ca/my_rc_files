!/bin/bash
#
# My basic post install procedure after ubuntu intalation
#
 
# Beginning
clear
echo 
echo =====================
echo Beginning the process
echo =====================

# Enabling the 3 lines above will be required a RETURN before each command 
#trap "set +x; sleep 5; set -x" DEBUG # Adding pause between commands
#set -x  # show command
#trap read debug  # require a RETURN after each command executed

# Packages to Install
sudo apt-get install -y curl git
echo Setting Packages to be installed
developers='vim terminator htop p7zip-full zsh httpie gcc g++ make cmake ctags python3-pip python3-dev python3-venv libpq-dev build-essential nodejs'
zsh='zsh powerline fonts-powerline zsh-theme-powerlevel9k zsh-syntax-highlighting'
python_pip='docker-compose flake8 ipython isort jupyter jupyterlab pipenv pylint requests' 
network='ssh remmina net-tools network-manager-openvpn network-manager-openvpn-gnome'
video='vlc'
apps='calibre ranger sxiv hexchat chromium-browser google-chrome-stable chrome-gnome-shell'
i3='i3 i3-wm i3blocks i3lock i3status powerline fonts-powerline zsh-theme-powerlevel9k zsh-syntax-highlighting'
docker='apt-transport-https ca-certificates software-properties-common gnupg-agent docker-ce'
vpn='nordvpn'
snaps='code'
utils='xclip'
pentest_tools='nikto dirsearch'

# Adding nodejs on source list
curl -sL https://deb.nodesource.com/setup_10.x | sudo bash

# Cloning my repositories
read -n 1 -s -r -p "It's time to copy your ssh key to ~/.ssh, after press any key to continue"
chmod 400 ~/.ssh/id_rsa #adding permission only for my user
ssh-add ~/.ssh/id_rsa #adding the my key to ssh agent
git config --global user.email "toguko@gmail.com"
git config --global user.name "Rafael 'Toguko' Dias"
mkdir ~/GITHUB
cd ~/GITHUB
curl -s https://api.github.com/users/toguko/repos | grep \"ssh_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone
# Clonning zsh-autosuggestion
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
cd ~/

echo Setting up Repositories
echo Setting DOCKER
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo Setting Google Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'

echo Papirus Icon
sudo add-apt-repository ppa:papirus/papirus

# Adding NordVPN
cd Download
sudo wget -qnc https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb
sudo dpkg -i nordvpn-release_1.0.0_all.deb
cd ~/

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
sudo apt-get install -y $gnome
sudo apt-get install -y $neovim
sudo apt-get install -y $vpn
sudo apt-get install -y $utils
sudo apt-get install -y $pentest_tools

echo Installing tools from snapcraft
sudo snap install telegram-desktop cheat insomnia remmina amass
sudo snap install slack --classic
sudo snap install code --classic
sudo snap install skype --classic
sudo snap install heroku --classic

echo Instaling pip packages
sudo -H pip3 install virtualenv
sudo -H pip3 install wheel
sudo -H pip3 install --upgrade setuptools

echo Installing Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended
chsh -s /bin/zsh
sudo usermod -s /usr/bin/zsh $(whoami)

#echo Download and Setting Dropbox
## Dropbox
#cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
#~/.dropbox-dist/dropboxd

# Dotfiles section
# This section is dedicated to the dot files (.bash, .vimrc...) installed in your home folder.
# Adicionar aqui minha configuracao do vim no github igual o acima
#echo Copying I3WM Config
#curl -o ~/.config/i3/config --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.config/i3/config
#curl -o ~/.config/i3/i3blocks/i3blocks.conf --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.config/i3/i3blocks/i3blocks.conf

echo Copying ZSH Config
curl -o ~/.zshrc --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.zshrc

echo Copying Terminator Config
curl -o ~/.config/terminator/config --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.config/terminator/config

echo Copying VIM Config
curl -o ~/.vimrc --create-dirs https://raw.githubusercontent.com/toguko/my_rc_files/master/.vimrc

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer

echo Add your user account to the docker group and to start on boot
sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

#echo Setting Nordic Theme
#sudo mkdir /usr/share/themes/Nordic
#cd /usr/share/themes/Nordic
#sudo git clone https://github.com/EliverLara/Nordic.git .
#gsettings set org.gnome.desktop.interface gtk-theme "Nordic"
#gsettings set org.gnome.desktop.wm.preferences theme "Nordic" 
#gsettings set org.gnome.desktop.interface icon-theme "Papirus-Dark"

echo Setting Font
cd
mkdir ~/.fonts
cd ~/.fonts
curl 'https://github.com/toguko/my_rc_files/blob/master/.fonts/Menlo%20for%20Powerline.ttf?raw=true' > 'Menlo for Powerline.ttf'
fc-cache -vf ~/.fonts

echo Instaling Pyenv
cd ~/.GITHUB
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.zshrc

# Installing some pentest tools
cd ~/GITHUB
echo Installing httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

echo Installing Nuclei
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest

echo Installing Metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && chmod 755 msfinstall && ./msfinstall

echo Installing Osmedeus
bash -c "$(curl -fsSL https://raw.githubusercontent.com/osmedeus/osmedeus-base/master/install.sh)"

echo Installing Masscan
cd ~/GITHUB
git clone https://github.com/robertdavidgraham/masscan
cd masscan
make
make install
cd

echo Clean everything
# Clean everything
sudo apt-get -y autoremove && sudo apt-get clean

echo -------------------------------------------------------------------------------------
echo Open VPN GUI installed, do not forge to mark the option:
echo "Use this connection only for resources on its network" on the IPV4 and IPV6 tabs
echo -------------------------------------------------------------------------------------

echo -------------------------------------------------------------------------------------
echo FRESH INSTALL FINISHED, ENJOY YOUR NEW MACHINE.
echo -------------------------------------------------------------------------------------
