install ubuntu minimal
sudo apt-get install update

# Installing Terminator and ZSH
sudo apt-get install -y terminator zsh

# Installing Oh-my-zsh
# https://gist.github.com/renshuki/3cf3de6e7f00fa7e744a
sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# Configuring .zshrc
# Install powerline font
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
mkdir ~/.fonts/
mv PowerlineSymbols.otf ~/.fonts/
mkdir -p .config/fontconfig/conf.d #if directory doesn't exists
fc-cache -vf ~/.fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

# https://dev.to/mskian/install-z-shell-oh-my-zsh-on-ubuntu-1804-lts-4cm4
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$HOME/.zsh-syntax-highlighting" --d$
echo "source $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> "$HOME/.zshrc"


mkdir GITHUB
cd GITHUB
curl -s https://api.github.com/users/toguko/repos | grep \"clone_url\" | awk '{print $2}' | sed -e 's/"//g' -e 's/,//g' | xargs -n1 git clone



sudo apt-get install vim, nvim, python3-pip, git zsh

sudo apt-get install -y ubuntu-drivers-common, ttf-ubuntu-font-family, poenssh-client

sudo apt-get install -y i3, i3-wm i3blocks i3lock i3status

sudo apt-get install xorg xserver-xorg mesa-utils mesa-utils-extra lightdm


wget -c https://github.com/FortAwesome/Font-Awesome/blob/master/fonts/fontawesome-webfont.ttf
sudo mkdir -p /usr/local/share/fonts
cd Downloads/
ls
sudo mv fontawesome-webfont.ttf /usr/local/share/fonts/
sudo mv fa-regular-400.ttf /usr/local/share/fonts/
sudo fc-cache -v


sudo apt-get install chromium


sudo apt-get install ranger, sxiv

sudo apt-get install -y ubuntu-wallpapers-disco
cp /usr/share/backgrounds/Dingo_Wallpaper_Grey_4096x2304.png /XYZ


DOCKER
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
sudo apt install docker-ce

